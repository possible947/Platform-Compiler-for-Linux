#!/usr/bin/env python3
"""Builds report.json / report.md / sources.json / run.json from collected facts."""
import hashlib, json, os, re, subprocess, sys, datetime

WORK, OUTDIR, REPO, STARTED = sys.argv[1:5]
F = json.load(open(f"{WORK}/facts.json"))
A = json.load(open(f"{WORK}/acpi.json"))
now = datetime.datetime.now().astimezone().isoformat(timespec="seconds")


def sha(p):
    return hashlib.sha256(open(p, "rb").read()).hexdigest()


K, U = "known", "unknown"
TABLE_BY_SIG = {}
for t in F["acpi_tables"]:
    TABLE_BY_SIG.setdefault(t["signature"], []).append(t)

# ---------------- sources ----------------
sources = [
    ("S-DMI", "observed_target", "sysfs", "/sys/class/dmi/id/*", "SMBIOS identity (serials/UUID deliberately excluded)"),
    ("S-CPUINFO", "observed_target", "procfs", "/proc/cpuinfo", "CPU identity, flags, apicid, microcode"),
    ("S-LSCPU", "observed_target", "command", "lscpu", "CPU summary, cache totals"),
    ("S-CPUSYS", "observed_target", "sysfs", "/sys/devices/system/cpu/cpu*/topology, /cache, /cpufreq, /acpi_cppc, /smt", "Topology, caches, hardware freq limits, CPPC capability registers"),
    ("S-NODE", "observed_target", "sysfs", "/sys/devices/system/node/node*", "NUMA membership, memory, distance"),
    ("S-EDAC", "observed_target", "sysfs", "/sys/devices/system/edac/mc/*", "IMC/channel/DIMM presence reported by EDAC (skx_edac)"),
    ("S-PCI", "observed_target", "sysfs+command", "/sys/bus/pci/devices/*; lspci -nn -D; lspci -tvnn", "PCI inventory, link capability/state, numa_node (unprivileged: capability registers not decoded by lspci)"),
    ("S-IOMMU", "observed_target", "sysfs", "/sys/class/iommu, /sys/kernel/iommu_groups, /proc/cmdline", "Kernel-visible IOMMU instances/groups"),
    ("S-RAPL", "observed_target", "sysfs", "/sys/class/powercap/intel-rapl:*", "Power-domain names exposed (names only)"),
    ("S-EFI", "observed_target", "sysfs", "/sys/firmware/efi, /sys/firmware/acpi/pm_profile, /sys/firmware/acpi/tables (names/sizes)", "UEFI presence, live ACPI table names/sizes"),
    ("S-ACPI-CAP", "observed_target", "file", "ACPI/*.aml (repository-supplied capture)", "Captured ACPI binaries; sha256 in report.acpi.tables"),
    ("D-ACPI", "deterministic_derived", "python", "helpers/acpi_parse.py", "Binary parse of SRAT/SLIT/MADT/MCFG/DMAR/HPET and kernel cross-checks"),
    ("D-IASL", "deterministic_derived", "command", "iasl -d (ACPICA 20260930) of captured tables", "Standalone disassembly of each table; AML inventory counts"),
    ("D-COLLECT", "deterministic_derived", "python", "helpers/collect.py", "Collector producing facts.json"),
    ("D-MEMBW", "deterministic_derived", "arithmetic", "channels x transfer-rate x 8 B", "Theoretical documented-maximum bandwidth from ARK DDR4-2933, 6 channels"),
]
sources = [dict(id=i, **{"class": c, "kind": k, "locator": l, "description": d, "observed_at": now, "content_sha256": None}) for i, c, k, l, d in sources]
for s in sources:
    if s["id"] == "S-ACPI-CAP":
        s["content_sha256"] = {t["file"]: t["sha256"] for t in F["acpi_tables"]}
sources.append({
    "id": "X-ARK-6248", "class": "external_authoritative", "kind": "vendor_documentation",
    "locator": "https://www.intel.com/content/www/us/en/products/sku/192446/intel-xeon-gold-6248-processor-27-5m-cache-2-50-ghz/specifications.html",
    "title": "Intel Xeon Gold 6248 Processor Specifications (Intel ARK)", "provider": "Intel", "observed_at": now, "content_sha256": None,
    "description": "Fetched as unlabeled markdown; only unambiguous values used: base 2.50 GHz, max turbo 3.90 GHz, TDP 150 W, Tcase 86 C, DDR4-2933, 6 memory channels, 3 UPI links, codename Cascade Lake. Per-active-core turbo and AVX frequency tables not present on this page.",
})
sources.append({"id": "M-INFER", "class": "model_inference", "kind": "inference", "locator": "n/a", "description": "Interpretive labels (e.g. chipset family naming from PCI IDs) marked as inference in report", "observed_at": now, "content_sha256": None})

# ---------------- platform / firmware ----------------
dmi = F["dmi"]
platform = {
    "architecture": {"state": K, "value": "x86_64", "refs": ["S-LSCPU"]},
    "system": {"state": K, "vendor": dmi["sys_vendor"], "product_name": dmi["product_name"], "product_version": dmi["product_version"], "chassis_type": dmi["chassis_type"], "refs": ["S-DMI"]},
    "board": {"state": K, "vendor": dmi["board_vendor"], "name": dmi["board_name"], "version": dmi["board_version"], "refs": ["S-DMI"]},
    "platform_generation": {"state": K, "value": "Intel Purley-class dual-socket server platform: 2nd Gen Intel Xeon Scalable (Cascade Lake) with C620-series PCH", "basis": "CPU codename from Intel ARK (X-ARK-6248); PCH identified from PCI IDs (S-PCI)", "refs": ["X-ARK-6248", "S-PCI"]},
    "chipset": {"state": K, "pci_id": "8086:a1c1", "description": "Intel C621 Chipset LPC/eSPI Controller (00:1f.0) among C620 Series Chipset Family functions", "refs": ["S-PCI"]},
    "pm_profile": {"state": K, "value": int(F["pm_profile"]), "meaning": "FADT preferred PM profile 4 = Enterprise Server (ACPI spec encoding)", "refs": ["S-EFI"]},
    "kernel_release_at_collection": {"state": K, "value": F["kernel"], "refs": ["S-CPUINFO"]},
    "baseboard_management": {"state": K, "value": "ASPEED AST2000-family VGA (1a03:2000) behind AST1150 bridge at 04:00.0 (BMC graphics)", "refs": ["S-PCI"]},
}
firmware = {
    "bios_vendor": {"state": K, "value": dmi["bios_vendor"], "refs": ["S-DMI"]},
    "bios_version": {"state": K, "value": dmi["bios_version"], "refs": ["S-DMI"]},
    "bios_date": {"state": K, "value": dmi["bios_date"], "refs": ["S-DMI"]},
    "uefi_present": {"state": K, "value": F["efi"], "refs": ["S-EFI"]},
    "acpi_fadt_revision": {"state": K, "value": next(t["revision"] for t in F["acpi_tables"] if t["signature"] == "FACP"), "refs": ["S-ACPI-CAP"]},
    "smbios_memory_devices": {"state": "unavailable", "reason": "dmidecode / /sys/firmware/dmi/tables require root; not available to this run", "refs": []},
}

# ---------------- CPU ----------------
c0 = F["cpuinfo_cpu0"]
flags = set(F["cpuinfo_flags"])
want = ["sse4_2", "avx", "avx2", "fma", "avx512f", "avx512dq", "avx512cd", "avx512bw", "avx512vl", "avx512_vnni", "avx512_bf16", "aes", "vmx", "hwp", "hwp_epp", "hwp_act_window", "hwp_pkg_req", "est", "ida", "dtherm", "pln", "pts", "rdt_a", "cat_l3", "mba", "intel_pt", "x2apic"]
caches = []
for c in F["caches"]["0"]:
    caches.append({"level": c["level"], "type": c["type"], "size": c["size"], "ways": c["ways_of_associativity"], "shared_cpu_list_cpu0": c["shared_cpu_list"]})
l3_20 = next(c for c in F["caches"]["20"] if c["level"] == "3")
cores_pkg = F["physical_cores_per_package"]
cpu = {
    "model_name": {"state": K, "value": c0["model name"], "refs": ["S-CPUINFO"]},
    "vendor": {"state": K, "value": "GenuineIntel", "refs": ["S-CPUINFO"]},
    "family_model_stepping": {"state": K, "family": int(c0["cpu family"]), "model": int(c0["model"]), "model_hex": hex(int(c0["model"])), "stepping": int(c0["stepping"]), "refs": ["S-CPUINFO"]},
    "microcode": {"state": K, "value": c0.get("microcode"), "refs": ["S-CPUINFO"]},
    "microarchitecture": {"state": K, "value": "Cascade Lake (Cascade Lake-SP server, 14 nm)", "basis": "Intel ARK product collection for Xeon Gold 6248", "refs": ["X-ARK-6248"]},
    "topology": {
        "sockets": {"state": K, "value": len(cores_pkg), "refs": ["S-CPUSYS"]},
        "physical_cores_per_socket": {"state": K, "value": cores_pkg, "refs": ["S-CPUSYS"]},
        "logical_cpus": {"state": K, "value": len(F["cpu_topology"]), "refs": ["S-CPUSYS"]},
        "threads_per_core": {"state": K, "value": 2, "smt_active": True, "refs": ["S-CPUSYS", "S-LSCPU"]},
        "dies_per_socket": {"state": K, "value": 1, "note": "kernel die_id is 0 for package 0 and 1 for package 1 (one die per package; no sub-NUMA/COD split exposed)", "refs": ["S-CPUSYS"]},
        "cpu_to_socket": {"state": K, "value": {str(p): [int(n) for n, c in F["cpu_topology"].items() if c["package"] == p] for p in (0, 1)}, "refs": ["S-CPUSYS"]},
        "cpu_to_numa": {"state": K, "value": {n: v["cpulist"] for n, v in F["numa"].items()}, "refs": ["S-NODE"]},
        "smt_sibling_example": {"cpu0": F["cpu_topology"]["0"]["siblings"], "cpu20": F["cpu_topology"]["20"]["siblings"]},
        "socket_interconnect": {"state": K, "value": "3 UPI links per processor (vendor spec); link state/topology between sockets not observable from OS", "refs": ["X-ARK-6248"], "observed_link_state": "unavailable"},
    },
    "caches": {"state": K, "cpu0": caches, "l3_shared_cpu_list_cpu20": l3_20["shared_cpu_list"], "lscpu_totals": "L1d 1.3 MiB (40), L1i 1.3 MiB (40), L2 40 MiB (40), L3 55 MiB (2 instances)", "refs": ["S-CPUSYS", "S-LSCPU"]},
    "frequency_capability": {
        "base_mhz": {"state": K, "value": 2500, "refs": ["X-ARK-6248", "S-CPUSYS"], "note": "kernel base_frequency 2500000 kHz and CPPC nominal_perf 25 agree"},
        "max_turbo_mhz_single_core": {"state": K, "value": 3900, "refs": ["X-ARK-6248", "S-CPUSYS"], "note": "kernel cpuinfo_max_freq 3900000 kHz and CPPC highest_perf 39 agree"},
        "min_mhz": {"state": K, "value": 1000, "refs": ["S-CPUSYS"], "note": "kernel cpuinfo_min_freq; CPPC lowest_perf=7 (x100 MHz) => 700 MHz differs from cpuinfo_min_freq (see unknowns/notes)"},
        "turbo_by_active_core_count": {"state": U, "values": []},
        "documented_all_core_turbo": {"state": U},
        "avx_frequency_behavior": {"state": U},
    },
    "cppc": {"state": K, "present_in_firmware": True, "per_cpu_objects_in_AML": 112, "registers_cpu0": {"highest_perf": 39, "nominal_perf": 25, "lowest_nonlinear_perf": 10, "lowest_perf": 7, "guaranteed_perf": 25, "reference_perf": 25}, "refs": ["S-CPUSYS", "D-IASL"], "note": "_CPC methods found in OEM2 (OEM table id 'CPU  HWP')"},
    "hwp": {"state": K, "supported": True, "flags_present": sorted(f for f in ("hwp", "hwp_epp", "hwp_act_window", "hwp_pkg_req") if f in flags), "refs": ["S-CPUINFO"]},
    "eist_pstates": {"state": K, "est_flag": "est" in flags, "turbo_flag_ida": "ida" in flags, "firmware_pstate_tables": "OEM table id 'CPU EIST' present (OEM1)", "refs": ["S-CPUINFO", "S-ACPI-CAP"]},
    "instruction_sets": {"state": K, "flags": {f: (f in flags) for f in want}, "refs": ["S-CPUINFO"], "note": "AVX-512 F/DQ/CD/BW/VL/VNNI present; avx512_bf16 absent"},
    "tdp_w": {"state": K, "value": 150, "refs": ["X-ARK-6248"]},
    "thermal_limit": {"state": K, "tcase_c": 86, "refs": ["X-ARK-6248"], "note": "ARK Tcase; PROCHOT/TjMax not read (MSR access not permitted)"},
    "thermal_features": {"state": K, "flags": [f for f in ("dtherm", "pln", "pts") if f in flags], "refs": ["S-CPUINFO"]},
    "power_domains": {"state": K, "rapl_powercap_domains": ["package-0", "dram (package-0)", "package-1", "dram (package-1)"], "refs": ["S-RAPL"], "note": "core/uncore subdomains not exposed via powercap"},
    "resource_director": {"state": K, "flags": [f for f in ("rdt_a", "cat_l3", "cdp_l3", "mba", "cqm") if f in flags], "refs": ["S-CPUINFO"]},
}

# ---------------- memory ----------------
chan = []
tot = 0
for mc, v in F["edac"].items():
    for dn, d in v["dimms"].items():
        chan.append({"mc": mc, "controller": v["mc_name"], "location": d["dimm_location"], "size_mib": int(d["size"]), "type_reported": d["dimm_mem_type"], "device_width": d["dimm_dev_type"], "edac_mode": d["dimm_edac_mode"]})
        tot += int(d["size"])
node_mem = {n: v["mem_total_kb"] for n, v in F["numa"].items()}
memory = {
    "total_installed_memory": {"state": K, "kernel_memtotal_gib": round(F["meminfo_total_kb"] / 2**20, 2), "edac_dimm_total_gib": tot / 1024, "refs": ["S-NODE", "S-EDAC"], "note": "kernel MemTotal is lower than installed capacity by firmware/kernel reservations"},
    "per_numa_node_kernel_memtotal_gib": {"state": K, "value": {n: round(v / 2**20, 2) for n, v in node_mem.items()}, "refs": ["S-NODE"]},
    "controllers": {"state": K, "value": "2 sockets x 2 integrated memory controllers x 3 channels = 12 channels (EDAC); vendor spec: 6 channels per processor", "refs": ["S-EDAC", "X-ARK-6248"]},
    "channel_population": {"state": K, "value": chan, "per_imc_pattern_mib": [32768, 8192, 8192], "uniform_across_imcs": len({tuple(c["size_mib"] for c in chan if c["mc"] == m) for m in F["edac"]}) == 1, "refs": ["S-EDAC"], "note": "12 channels each with one DIMM (slot 0); 32/8/8 GiB per IMC is the EDAC-reported capacity pattern. DIMM type reported by EDAC only; not confirmed against SMBIOS."},
    "dimm_identity": {"state": "unavailable", "reason": "part numbers/serials/rank/speed need SMBIOS Type 17 (root)", "refs": []},
    "configured_speed": {"state": U, "reason": "not observable without SMBIOS/MSR access; processor supports up to DDR4-2933 (vendor)", "refs": ["X-ARK-6248"]},
    "documented_max_bandwidth": {"state": K, "per_socket_gb_s": round(2933e6 * 8 * 6 / 1e9, 1), "basis": "DDR4-2933 x 8 bytes x 6 channels (vendor maximum, not configured speed; actual speed unknown)", "refs": ["D-MEMBW", "X-ARK-6248"]},
}
numa = {
    "node_count": {"state": K, "value": len(F["numa"]), "refs": ["S-NODE"]},
    "nodes": {n: {"cpulist": v["cpulist"], "mem_total_gib": round(v["mem_total_kb"] / 2**20, 2)} for n, v in F["numa"].items()},
    "distance_matrix": {"state": K, "value": [v["distance"] for v in F["numa"].values()], "refs": ["S-NODE", "D-ACPI"]},
    "socket_node_relationship": {"state": K, "value": "node0 = socket 0 (CPUs 0-19,40-59); node1 = socket 1 (CPUs 20-39,60-79); 1:1", "refs": ["S-CPUSYS", "S-NODE"]},
    "memoryless_nodes": {"state": K, "value": [], "refs": ["S-NODE"]},
    "srat": A["srat"],
    "slit": A["slit"],
}

# ---------------- PCI ----------------
pci = F["pci"]
roots = sorted({a.split(":")[1] for a in pci})
root_bus = {}
for a, r in pci.items():
    m = re.match(r"pci0000:(\w\w)", r["realpath"])
    root_bus.setdefault(m.group(1), []).append(a)
rootsum = {rb: {"device_count": len(v), "numa_node": pci[v[0]]["numa_node"]} for rb, v in sorted(root_bus.items())}
names = {l.split(" ", 1)[0]: l.split(" ", 1)[1] for l in F["pci_names"].splitlines() if l}
major = ["0000:00:11.5", "0000:00:14.0", "0000:00:17.0", "0000:01:00.0", "0000:02:00.0", "0000:04:00.0", "0000:5e:00.0", "0000:b1:00.0", "0000:da:00.0"]
endpoints = []
for a in major:
    r = pci[a]
    endpoints.append({"address": a, "description": names[a], "numa_node": int(r["numa_node"]), "driver_bound": r["driver"], "link_capability": f'{r["max_link_speed"]} x{r["max_link_width"]}', "link_current": f'{r["current_link_speed"]} x{r["current_link_width"]}'})


def path(a):
    out = []
    p = pci[a]["realpath"].split("/")[1:]
    for x in p:
        out.append(x)
    return [x for x in out if re.match(r"0000:", x)]


links = []
for a in ("0000:ae:00.0", "0000:af:00.0", "0000:b0:00.0", "0000:b1:00.0", "0000:d7:00.0", "0000:d8:00.0", "0000:d9:00.0", "0000:da:00.0", "0000:5d:00.0", "0000:5e:00.0", "0000:00:1c.0", "0000:00:1c.1", "0000:00:1c.5", "0000:01:00.0", "0000:02:00.0"):
    r = pci[a]
    links.append({"address": a, "max": f'{r["max_link_speed"]} x{r["max_link_width"]}', "current": f'{r["current_link_speed"]} x{r["current_link_width"]}', "numa_node": int(r["numa_node"])})
gpu_paths = {a: path(a) for a in ("0000:b1:00.0", "0000:da:00.0", "0000:5e:00.0")}
pcidict = {
    "segments": {"state": K, "value": ["0000"], "mcfg": A["mcfg"], "refs": ["S-PCI", "D-ACPI"]},
    "root_buses": {"state": K, "kernel_visible_roots": rootsum, "refs": ["S-PCI"]},
    "device_count": len(pci),
    "hierarchy_tree": {"state": K, "ref": "sources: lspci -tvnn -D (retained in work/facts.json as pci_vv_tree)", "refs": ["S-PCI"]},
    "major_endpoints": endpoints,
    "paths_to_major_endpoints": gpu_paths,
    "links_capability_vs_current": links,
    "link_state_note": "Observation only; sysfs max/current speed/width. Endpoint & bridge capability registers not decoded (unprivileged). Link state at collection time may be power-managed (idle).",
    "gpus": [{"address": a, "description": names[a], "numa_node": 1, "driver_bound": pci[a]["driver"]} for a in ("0000:b1:00.0", "0000:da:00.0")],
    "gpu_notes": "Two AMD Vega 20 [Radeon Pro VII / Instinct MI50] accelerators (1002:66a1), each behind an AMD PCIe switch (upstream 14a0 / downstream 14a1) on a Skylake-E root port (ae:00.0 / d7:00.0), both on NUMA node 1.",
    "storage": [{"address": "0000:5e:00.0", "description": names["0000:5e:00.0"], "numa_node": 0}, {"address": "0000:00:11.5", "description": names["0000:00:11.5"]}, {"address": "0000:00:17.0", "description": names["0000:00:17.0"]}],
    "network": [{"address": a, "description": names[a], "numa_node": 0} for a in ("0000:01:00.0", "0000:02:00.0")],
    "usb_external_io": [{"address": "0000:00:14.0", "description": names["0000:00:14.0"]}],
    "numa_locality_counts": {"node0": sum(1 for r in pci.values() if r["numa_node"] == "0"), "node1": sum(1 for r in pci.values() if r["numa_node"] == "1")},
    "bar_resources": {"state": "not_collected", "reason": "not required to describe platform identity; resource files readable but not enumerated"},
    "acpi_ownership_note": "No ACPI semantic ownership inferred from PCI proximity.",
}
iommu = {
    "firmware_dmar": {"state": K, "present": True, **A["dmar"], "refs": ["D-ACPI"], "note": "Flags 0x1 = INTR_REMAP supported per ACPI DMAR encoding bit 0"},
    "kernel_visible": {"state": K, "instances": len(F["iommu"]["class_iommu"]), "iommu_groups": F["iommu"]["groups"], "cmdline_iommu_params": F["iommu"]["cmdline_iommu"], "refs": ["S-IOMMU"]},
    "capability_registers": {"state": "unavailable", "reason": "DRHD capability/extended-capability registers not read (MMIO / root)"},
}

# ---------------- ACPI ----------------
live_ok = {t["file"][:-4]: F["live_acpi_sizes"].get(t["file"][:-4]) == t["file_size"] for t in F["acpi_tables"]}
acpi = {
    "capture_source": "repository ./ACPI/*.aml (supplied capture); live /sys/firmware/acpi/tables files are root-only so hashes could not be compared, only names and sizes",
    "table_count": len(F["acpi_tables"]),
    "live_table_names_and_sizes_match_capture": all(live_ok.values()) and len(F["live_acpi_sizes"]) == len(F["acpi_tables"]),
    "tables": [{"file": t["file"], "signature": t["signature"], "length": t["length"], "revision": t["revision"], "oem_id": t["oem_id"], "oem_table_id": t["oem_table_id"], "oem_revision": hex(t["oem_revision"]), "compiler": f'{t["compiler_id"]} {hex(t["compiler_revision"])}', "sha256": t["sha256"]} for t in F["acpi_tables"]],
    "aml_bearing_tables": [t["file"] for t in F["acpi_tables"] if t["signature"] in ("DSDT", "SSDT")],
    "aml_disassembly": {"tool": "iasl 20260930", "result": "each of DSDT, OEM1, OEM2, OEM4, SSDT1-4 disassembled standalone with zero error lines", "refs": ["D-IASL"]},
    "aml_inventory": {"dsdt_pci_host_bridges_PNP0A08": 24, "dsdt_processor_objects": 112, "oem2_cpc_methods": 112, "oem_table_ids": {"OEM1": "CPU EIST", "OEM2": "CPU  HWP", "OEM4": "CPU  CST", "SSDT2": "SSDT  PM", "SSDT1": "ADDRXLAT", "SSDT4": "SpsNm"}, "refs": ["D-IASL"], "note": "Existence inventory only; no semantic evaluation."},
    "madt": A["madt"], "mcfg": A["mcfg"], "hpet": A["hpet"], "dmar_summary": {"drhd_count": len(A["dmar"]["drhd"]), "subtable_counts": A["dmar"]["subtable_type_counts"]},
    "srat_summary": A["srat"], "slit_summary": A["slit"],
    "crosschecks": A["crosscheck"],
}

# ---------------- contradictions / unknowns ----------------
contradictions = [
    {"id": "contradiction-001", "subject": "IOMMU/VT-d: firmware description vs kernel-visible state",
     "claim_a": {"value": "DMAR present with 8 DRHD units and INTR_REMAP flag set", "source_refs": ["D-ACPI", "S-ACPI-CAP"]},
     "claim_b": {"value": "No IOMMU instances in /sys/class/iommu and zero IOMMU groups; no iommu parameters on command line", "source_refs": ["S-IOMMU"]},
     "resolution": "unresolved", "note": "Cause not established in Step 1; kernel log unreadable (dmesg restricted)."},
    {"id": "contradiction-002", "subject": "PCI root count: AML host bridges vs kernel-visible root buses",
     "claim_a": {"value": "DSDT declares 24 PNP0A08 host bridges (PC00-PC23)", "source_refs": ["D-IASL"]},
     "claim_b": {"value": "Kernel exposes 8 PCI root buses (00,17,3a,5d,80,85,ae,d7) in a single segment", "source_refs": ["S-PCI"]},
     "resolution": "unresolved", "note": "Recorded as a structural difference only; not classified as a defect."},
    {"id": "contradiction-003", "subject": "Minimum CPU performance: cpufreq minimum vs CPPC lowest_perf",
     "claim_a": {"value": "cpuinfo_min_freq = 1000000 kHz (1000 MHz)", "source_refs": ["S-CPUSYS"]},
     "claim_b": {"value": "acpi_cppc lowest_perf = 7 (≈700 MHz at 100 MHz ratio)", "source_refs": ["S-CPUSYS"]},
     "resolution": "unresolved"},
    {"id": "contradiction-004", "subject": "Enabled logical CPUs vs AML/MADT declared processor slots",
     "claim_a": {"value": "80 CPUs online; SRAT/MADT enabled APIC entries = 80", "source_refs": ["S-CPUSYS", "D-ACPI"]},
     "claim_b": {"value": "DSDT declares 112 Processor objects; MADT lists 112 lapic + 112 x2apic entries (32 lapic disabled, all x2apic entries disabled)", "source_refs": ["D-ACPI", "D-IASL"]},
     "resolution": "unresolved", "note": "Informational: firmware describes a larger capacity than populated; not a kernel/firmware disagreement on enabled CPUs (all 80 enabled CPUs match between kernel, MADT and SRAT)."},
]
unknowns = [
    {"field": "cpu.frequency_capability.turbo_by_active_core_count", "state": U, "reason": "Intel ARK page gives only max single-core turbo; turbo-ratio-limit MSR not readable (no root); no authoritative per-active-core table retrieved", "attempted_sources": ["X-ARK-6248", "MSR (not permitted)"]},
    {"field": "cpu.frequency_capability.documented_all_core_turbo", "state": U, "reason": "Not on retrieved page", "attempted_sources": ["X-ARK-6248"]},
    {"field": "cpu.frequency_capability.avx_frequency_behavior", "state": U, "reason": "No authoritative AVX2/AVX-512 frequency table retrieved", "attempted_sources": ["X-ARK-6248"]},
    {"field": "memory.dimm_identity / configured_speed", "state": "unavailable", "reason": "SMBIOS Type 17 requires root", "attempted_sources": ["dmidecode (password required)"]},
    {"field": "pci.endpoint_capability_registers (decoded)", "state": "unavailable", "reason": "lspci -vv hides capability registers for non-root; sysfs speed/width used instead", "attempted_sources": ["lspci -vvnn"]},
    {"field": "iommu.drhd_capability_registers", "state": "unavailable", "reason": "MMIO/root access", "attempted_sources": []},
    {"field": "cpu.socket_interconnect.upi_link_state", "state": "unavailable", "reason": "Not observable from OS without MSR/uncore access", "attempted_sources": []},
    {"field": "cpu.thermal_limit.tjmax", "state": "unavailable", "reason": "MSR 0x1A2 not readable", "attempted_sources": []},
    {"field": "acpi.live_vs_captured_hashes", "state": "unavailable", "reason": "/sys/firmware/acpi/tables files are root-only; only sizes/names compared", "attempted_sources": ["/sys/firmware/acpi/tables"]},
    {"field": "pci.bar_resources", "state": "not_collected", "reason": "Not needed for platform identity", "attempted_sources": []},
    {"field": "firmware.kernel_boot_log_facts", "state": "unavailable", "reason": "dmesg restricted", "attempted_sources": ["dmesg"]},
]
limitations = [
    "Run was unprivileged (uid 1000): no MSR, SMBIOS table, PCI capability decode, MMIO, or kernel log access.",
    "ACPI analysis used the repository-supplied capture in ./ACPI; hashes were not verified against live firmware tables (root-only), only file names/sizes matched.",
    "Intel ARK page was retrieved as unlabeled markdown; only unambiguous values were used.",
    "Link current state is a point-in-time observation and may reflect link power management.",
    "No stress/workload tests were run; no target policy was changed.",
]
report = {
    "schema_version": "1", "stage": "step_1_platform_specification", "status": "complete_with_unknowns",
    "platform": platform, "cpu": cpu, "memory": memory, "numa": numa, "pci": pcidict, "firmware": firmware, "acpi": acpi, "iommu": iommu,
    "contradictions": contradictions, "unknowns": unknowns, "limitations": limitations,
    "evidence_refs": [s["id"] for s in sources],
}

json.dump(report, open(f"{OUTDIR}/report.json", "w"), indent=2)
json.dump({"schema_version": "1", "sources": sources}, open(f"{OUTDIR}/sources.json", "w"), indent=2)

# ---------------- report.md ----------------
L = []
w = L.append
w("# Step 1 Platform Specification\n")
w(f"Status: **{report['status']}** — generated {now}\n")
w("## Platform identity")
w(f"- System/board: {dmi['sys_vendor']} {dmi['product_name']} (board version {dmi['board_version']}); chassis type {dmi['chassis_type']}")
w(f"- Platform: {platform['platform_generation']['value']}")
w(f"- Chipset: {platform['chipset']['description']} ({platform['chipset']['pci_id']})")
w(f"- Firmware: {dmi['bios_vendor']} BIOS {dmi['bios_version']} ({dmi['bios_date']}); UEFI: {F['efi']}; FADT revision {firmware['acpi_fadt_revision']['value']}; PM profile 4 (Enterprise Server)")
w("- BMC graphics: ASPEED AST2000-family (04:00.0)")
w(f"- Kernel at collection: {F['kernel']}\n")
w("## CPU")
w(f"- 2 × {c0['model name']} — family 6, model 85 (0x55), stepping {c0['stepping']}, microcode {c0.get('microcode')}; Cascade Lake (vendor ARK)")
w("- 20 cores/socket, 40 threads/socket, 80 logical CPUs, SMT active; 1 die/socket")
w("- node0 = socket 0 CPUs 0-19,40-59; node1 = socket 1 CPUs 20-39,60-79")
w("- Caches: L1d 32 KiB, L1i 32 KiB, L2 1 MiB per core; L3 27.5 MiB per socket (55 MiB total); L3 shared by 40 CPUs per socket")
w("- Frequency: base 2.5 GHz, max single-core turbo 3.9 GHz (ARK and kernel agree); min 1.0 GHz (cpufreq); turbo by active-core count, all-core turbo, AVX behavior: unknown")
w("- TDP 150 W; Tcase 86 °C (ARK); UPI: 3 links/processor (vendor)")
w("- HWP: supported (hwp, hwp_epp, hwp_act_window, hwp_pkg_req); CPPC objects in firmware (112 `_CPC`); registers cpu0 highest=39 nominal=25 lowest_nonlinear=10 lowest=7 guaranteed=25; EIST (est) and turbo (ida) flags present")
w("- ISA: SSE4.2, AVX, AVX2, FMA, AVX-512 (F/DQ/CD/BW/VL/VNNI), AES, VT-x; no avx512_bf16")
w("- RAPL domains: package-0, dram, package-1, dram; RDT: rdt_a, cat_l3, cdp_l3, mba, cqm\n")
w("## Memory and NUMA")
w(f"- Kernel MemTotal {report['memory']['total_installed_memory']['kernel_memtotal_gib']} GiB; EDAC DIMM total {tot/1024:.0f} GiB")
w(f"- Per node (kernel): " + ", ".join(f"node{n} {v:.2f} GiB" for n, v in memory["per_numa_node_kernel_memtotal_gib"]["value"].items()))
w("- Channels: 2 sockets × 2 IMC × 3 channels, all 12 populated with 1 DIMM; per IMC 32/8/8 GiB (EDAC; type reported Unbuffered-DDR4, unverified by SMBIOS)")
w(f"- Documented max: DDR4-2933 × 6 ch ≈ {memory['documented_max_bandwidth']['per_socket_gb_s']} GB/s per socket (vendor maximum; configured speed unknown)")
w("- NUMA distance matrix: [[10,21],[21,10]] (kernel == SLIT); no memoryless nodes")
w(f"- SRAT: {A['srat']['cpus_per_domain']} CPUs per domain; memory per domain GiB {A['srat']['memory_gib_per_domain']}\n")
w("## PCIe / I/O")
w(f"- Single PCI segment 0000 (MCFG base 0x80000000, buses 0-255); {len(pci)} devices; kernel root buses: {', '.join(sorted(rootsum))}")
w("- Node 0 roots: 00, 17, 3a, 5d; node 1 roots: 80, 85, ae, d7")
w("| Device | Description | NUMA | Capability | Current |\n|---|---|---|---|---|")
for e in endpoints:
    w(f"| {e['address']} | {e['description'][:70]} | {e['numa_node']} | {e['link_capability']} | {e['link_current']} |")
w("")
w("- GPUs: 2 × AMD Vega 20 (Radeon Pro VII / Instinct MI50, 1002:66a1) at b1:00.0 and da:00.0, node 1, each behind an AMD PCIe switch (14a0/14a1) on Skylake-E root ports ae:00.0 / d7:00.0")
w("- Link observations (cap → current): ae:00.0 8 GT/s x16 → 8 x16; af:00.0 (switch upstream) 16 x16 → 8 x16; b0:00.0 16 x16 → 16 x16; b1:00.0 16 x16 → 16 x16; d8:00.0 16 x16 → 8 x16; d9:00.0/da:00.0 16 x16 → 16 x16; 5d:00.0 8 x4 → 8 x4 (NVMe 5e:00.0 8 GT/s x4)")
w("- NICs: 2 × Intel I210 (01:00.0, 02:00.0; 2.5 GT/s x1); USB xHCI 00:14.0; SATA/sSATA AHCI 00:17.0 / 00:11.5")
w(f"- IOMMU: firmware DMAR with {len(A['dmar']['drhd'])} DRHD units (INTR_REMAP flag); kernel-visible IOMMU instances: {len(F['iommu']['class_iommu'])}, groups: {F['iommu']['groups']}\n")
w("## Firmware / ACPI inventory (captured ./ACPI)")
w(f"- {len(F['acpi_tables'])} tables; names and sizes match live /sys/firmware/acpi/tables; hashes in report.json")
w("| File | Sig | Len | Rev | OEM ID | OEM Table ID |\n|---|---|---|---|---|---|")
for t in F["acpi_tables"]:
    w(f"| {t['file']} | {t['signature']} | {t['length']} | {t['revision']} | {t['oem_id']} | {t['oem_table_id']} |")
w("")
w("- AML-bearing: DSDT, OEM1 (CPU EIST), OEM2 (CPU  HWP), OEM4 (CPU  CST), SSDT1-4; all disassemble with iasl with zero error lines")
w("- DSDT: 24 PNP0A08 host bridges, 112 Processor objects; OEM2: 112 `_CPC`")
w(f"- MADT: {A['madt']['counts']}; HPET @ {A['hpet']['address']}; DMAR HAW {A['dmar']['host_address_width']} bits")
w("- Cross-checks: kernel CPU→node vs SRAT: 0 mismatches over 80 CPUs; SLIT == kernel distances; APIC IDs of kernel CPUs == MADT/SRAT enabled IDs\n")
w("## Contradictions")
for c in contradictions:
    w(f"- **{c['id']}** {c['subject']}: A: {c['claim_a']['value']} | B: {c['claim_b']['value']} — {c['resolution']}")
w("\n## Unknowns")
for u in unknowns:
    w(f"- `{u['field']}` ({u['state']}): {u['reason']}")
w("\n## Limitations")
for l in limitations:
    w(f"- {l}")
open(f"{OUTDIR}/report.md", "w").write("\n".join(L) + "\n")

# ---------------- run.json ----------------
prompt = f"{REPO}/prompts/step_1/PROMPT.md"
rev = subprocess.run(["git", "-C", REPO, "rev-parse", "HEAD"], capture_output=True, text=True).stdout.strip()
run = {
    "schema_version": "1", "stage": "step_1_platform_specification", "status": "complete_with_unknowns",
    "started_at": STARTED, "completed_at": now,
    "prompt": {"path": "prompts/step_1/PROMPT.md", "sha256": sha(prompt)},
    "model": {"provider": "GitHub Copilot CLI", "model_id": "claude-sonnet-5.5"},
    "repository": {"revision": rev},
    "python": {"executable": ".venv/bin/python", "version": subprocess.run([f"{REPO}/.venv/bin/python", "-V"], capture_output=True, text=True).stdout.strip()},
    "isolation": "problems.md and goals.md were not read or used",
    "commands": ["uname -a", "lscpu", "cat /sys/class/dmi/id/*", "lspci -nnvmm / -nn -D / -tvnn / -vvnn", "dmidecode (sudo -n; denied)", "dmesg (denied)", "iasl -d <captured tables>", "helpers/collect.py", "helpers/acpi_parse.py", "helpers/build_report.py", "web_fetch Intel ARK 6248", "sysfs reads under /sys/devices/system/{cpu,node,edac}, /sys/bus/pci, /sys/class/{powercap,iommu}, /sys/kernel/iommu_groups"],
    "generated_helpers": ["helpers/collect.py", "helpers/acpi_parse.py", "helpers/build_report.py"],
    "limitations": limitations,
    "output_hashes": {},
}
for f in ("report.json", "report.md", "sources.json"):
    run["output_hashes"][f] = sha(f"{OUTDIR}/{f}")
for f in ("collect.py", "acpi_parse.py", "build_report.py"):
    run["output_hashes"]["helpers/" + f] = sha(f"{OUTDIR}/helpers/{f}")
json.dump(run, open(f"{OUTDIR}/run.json", "w"), indent=2)
print("built")
