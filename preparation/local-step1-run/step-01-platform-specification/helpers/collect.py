#!/usr/bin/env python3
"""Step 1 read-only deterministic collector. Writes facts.json to the work dir."""
import glob, hashlib, json, os, re, struct, subprocess, sys

OUT = sys.argv[1]
ACPI = sys.argv[2]


def rd(p):
    try:
        with open(p) as f:
            return f.read().strip()
    except Exception:
        return None


def rng(s):
    out = []
    if not s:
        return out
    for part in s.split(","):
        if "-" in part:
            a, b = part.split("-")
            out += list(range(int(a), int(b) + 1))
        elif part:
            out.append(int(part))
    return out


facts = {}

# CPU topology
cpus = {}
for d in sorted(glob.glob("/sys/devices/system/cpu/cpu[0-9]*"), key=lambda x: int(x.rsplit("cpu", 1)[1])):
    n = int(d.rsplit("cpu", 1)[1])
    t = d + "/topology"
    cpus[n] = {
        "package": int(rd(t + "/physical_package_id")),
        "die": int(rd(t + "/die_id") or -1),
        "core": int(rd(t + "/core_id")),
        "siblings": rd(t + "/thread_siblings_list"),
        "online": rd(d + "/online"),
        "numa": next((int(os.path.basename(x)[4:]) for x in glob.glob(d + "/node*")), None),
    }
facts["cpu_topology"] = cpus
pk = {}
for n, c in cpus.items():
    pk.setdefault(c["package"], set()).add((c["die"], c["core"]))
facts["physical_cores_per_package"] = {str(k): len(v) for k, v in pk.items()}
facts["logical_per_package"] = {str(p): sum(1 for c in cpus.values() if c["package"] == p) for p in pk}
facts["dies_per_package"] = {str(p): sorted({d for d, _ in v}) for p, v in pk.items()}

# caches (cpu0 and cpu20 representative)
caches = {}
for cpu in (0, 20):
    lst = []
    for d in sorted(glob.glob(f"/sys/devices/system/cpu/cpu{cpu}/cache/index*")):
        lst.append({k: rd(f"{d}/{k}") for k in ("level", "type", "size", "ways_of_associativity", "coherency_line_size", "number_of_sets", "shared_cpu_list")})
    caches[str(cpu)] = lst
facts["caches"] = caches

# frequency capability (hardware-exposed limits only)
cf = {}
for k in ("cpuinfo_min_freq", "cpuinfo_max_freq"):
    cf[k] = rd(f"/sys/devices/system/cpu/cpu0/cpufreq/{k}")
cf["base_frequency"] = rd("/sys/devices/system/cpu/cpu0/cpufreq/base_frequency")
facts["cpufreq_limits"] = cf
facts["cpuinfo_flags"] = next((l.split(":", 1)[1].split() for l in open("/proc/cpuinfo") if l.startswith("flags")), [])
facts["cpuinfo_cpu0"] = {l.split(":")[0].strip(): l.split(":", 1)[1].strip() for l in open("/proc/cpuinfo").read().split("\n\n")[0].splitlines() if ":" in l and not l.startswith("flags")}

# NUMA
nodes = {}
for d in sorted(glob.glob("/sys/devices/system/node/node[0-9]*")):
    n = int(d.rsplit("node", 1)[1])
    mi = rd(d + "/meminfo") or ""
    m = re.search(r"MemTotal:\s+(\d+) kB", mi)
    nodes[n] = {"cpulist": rd(d + "/cpulist"), "mem_total_kb": int(m.group(1)) if m else None,
                "distance": [int(x) for x in rd(d + "/distance").split()]}
facts["numa"] = nodes
facts["meminfo_total_kb"] = int(re.search(r"MemTotal:\s+(\d+)", open("/proc/meminfo").read()).group(1))

# EDAC DIMMs
edac = {}
for mc in sorted(glob.glob("/sys/devices/system/edac/mc/mc[0-9]*")):
    e = {"mc_name": rd(mc + "/mc_name"), "size_mb": rd(mc + "/size_mb"), "dimms": {}}
    for d in sorted(glob.glob(mc + "/dimm*")):
        e["dimms"][os.path.basename(d)] = {k: rd(f"{d}/{k}") for k in ("dimm_label", "dimm_location", "dimm_mem_type", "dimm_dev_type", "dimm_edac_mode", "size")}
    edac[os.path.basename(mc)] = e
facts["edac"] = edac

# PCI
pci = {}
for d in sorted(glob.glob("/sys/bus/pci/devices/*")):
    a = os.path.basename(d)
    r = {k: rd(f"{d}/{k}") for k in ("vendor", "device", "subsystem_vendor", "subsystem_device", "class", "revision", "numa_node", "current_link_speed", "current_link_width", "max_link_speed", "max_link_width", "enable")}
    r["driver"] = os.path.basename(os.readlink(d + "/driver")) if os.path.exists(d + "/driver") else None
    r["realpath"] = os.path.realpath(d).replace("/sys/devices/", "")
    r["iommu_group"] = os.path.basename(os.readlink(d + "/iommu_group")) if os.path.exists(d + "/iommu_group") else None
    pci[a] = r
facts["pci"] = pci
facts["pci_names"] = subprocess.run(["lspci", "-nn", "-D"], capture_output=True, text=True).stdout
facts["pci_vv_tree"] = subprocess.run(["lspci", "-tvnn", "-D"], capture_output=True, text=True).stdout
facts["iommu"] = {"class_iommu": os.listdir("/sys/class/iommu"), "groups": len(os.listdir("/sys/kernel/iommu_groups")),
                  "cmdline_iommu": [x for x in rd("/proc/cmdline").split() if "iommu" in x.lower() or "intel_iommu" in x.lower()],
                  "dmesg_available": None}

# SMBIOS identity
facts["dmi"] = {os.path.basename(p): rd(p) for p in glob.glob("/sys/class/dmi/id/*") if os.path.isfile(p) and "serial" not in p and "uuid" not in p and os.path.basename(p) not in ("uevent", "modalias")}
facts["efi"] = os.path.isdir("/sys/firmware/efi")
facts["pm_profile"] = rd("/sys/firmware/acpi/pm_profile")
facts["kernel"] = os.uname().release
facts["microcode"] = facts["cpuinfo_cpu0"].get("microcode")

# ACPI inventory from captured tables
tabs = []
for p in sorted(glob.glob(ACPI + "/*.aml")):
    b = open(p, "rb").read()
    sig, ln, rev, ck, oem, oemt, oemr, cid, crev = struct.unpack("<4sIBB6s8sI4sI", b[:36])
    tabs.append({"file": os.path.basename(p), "signature": sig.decode("latin1"), "length": ln, "file_size": len(b), "revision": rev,
                 "oem_id": oem.decode("latin1").strip(), "oem_table_id": oemt.decode("latin1").strip(), "oem_revision": oemr,
                 "compiler_id": cid.decode("latin1"), "compiler_revision": crev, "sha256": hashlib.sha256(b).hexdigest()})
facts["acpi_tables"] = tabs
# size comparison against live firmware table sizes (hash comparison not possible: root-only)
live = {}
for p in glob.glob("/sys/firmware/acpi/tables/*"):
    if os.path.isfile(p):
        try:
            live[os.path.basename(p)] = os.stat(p).st_size
        except Exception:
            pass
facts["live_acpi_sizes"] = live

json.dump(facts, open(OUT, "w"), indent=1, default=list)
print("ok")
