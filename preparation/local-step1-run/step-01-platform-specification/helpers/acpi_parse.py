#!/usr/bin/env python3
"""Deterministic binary parse of captured SRAT/SLIT/APIC/MCFG/DMAR/HPET and kernel cross-checks."""
import json, struct, sys, collections

ACPI, FACTS, OUT = sys.argv[1:4]
rd = lambda n: open(f"{ACPI}/{n}.aml", "rb").read()
res = {}

# SRAT
b = rd("SRAT")
off = 48
cpu_dom = {}
mem = []
while off < len(b):
    t, l = b[off], b[off + 1]
    e = b[off:off + l]
    if t == 0:
        dom = e[2] | (int.from_bytes(e[9:12], "little") << 8)
        flags = struct.unpack_from("<I", e, 4)[0]
        if flags & 1:
            cpu_dom[e[3]] = dom
    elif t == 1:
        dom, = struct.unpack_from("<I", e, 2)
        base, ln, fl = struct.unpack_from("<QQxxxxI", e, 8)[0], struct.unpack_from("<Q", e, 16)[0], struct.unpack_from("<I", e, 28)[0]
        mem.append({"domain": dom, "base": base, "length": ln, "flags": fl})
    elif t == 2:
        dom, apic, flags = struct.unpack_from("<IIII", e, 4)[:3]
        if flags & 1:
            cpu_dom[apic] = dom
    off += l
en = [m for m in mem if m["flags"] & 1 and m["length"]]
dm = collections.Counter()
for m in en:
    dm[m["domain"]] += m["length"]
res["srat"] = {"enabled_cpu_affinity_entries": len(cpu_dom),
               "cpus_per_domain": dict(collections.Counter(cpu_dom.values())),
               "enabled_memory_ranges": [{"domain": m["domain"], "base": hex(m["base"]), "length_gib": m["length"] / 2**30} for m in en],
               "memory_gib_per_domain": {str(k): v / 2**30 for k, v in dm.items()}}

# SLIT
b = rd("SLIT")
n = struct.unpack_from("<Q", b, 36)[0]
res["slit"] = {"localities": n, "matrix": [list(b[44 + i * n:44 + (i + 1) * n]) for i in range(n)]}

# MADT
b = rd("APIC")
off = 44
cnt = collections.Counter(); ids = {}
while off < len(b):
    t, l = b[off], b[off + 1]
    e = b[off:off + l]
    if t == 0:
        fl = struct.unpack_from("<I", e, 4)[0]
        cnt["lapic_enabled" if fl & 1 else "lapic_disabled"] += 1
        if fl & 1: ids[e[3]] = 1
    elif t == 9:
        apic, fl = struct.unpack_from("<II", e, 4)
        cnt["x2apic_enabled" if fl & 1 else "x2apic_disabled"] += 1
        if fl & 1: ids[apic] = 1
    elif t == 1:
        cnt["ioapic"] += 1
    else:
        cnt[f"type{t}"] += 1
    off += l
res["madt"] = {"counts": dict(cnt), "enabled_apic_ids": len(ids), "flags": hex(struct.unpack_from("<I", b, 40)[0])}

# MCFG
b = rd("MCFG")
base, seg, sb, eb = struct.unpack_from("<QHBB", b, 44)
res["mcfg"] = {"entries": [{"base": hex(base), "segment": seg, "start_bus": sb, "end_bus": eb}]}

# DMAR
b = rd("DMAR")
off = 48
d = collections.Counter(); drhd = []
while off < len(b):
    t, l = struct.unpack_from("<HH", b, off)
    d[t] += 1
    if t == 0:
        fl, sz, seg, base = struct.unpack_from("<BBHQ", b, off + 4)
        drhd.append({"segment": seg, "base": hex(base), "include_pci_all": bool(fl & 1)})
    off += l
res["dmar"] = {"host_address_width": b[36] + 1, "flags": hex(b[37]), "subtable_type_counts": {str(k): v for k, v in d.items()}, "drhd": drhd}

# HPET
b = rd("HPET")
res["hpet"] = {"address": hex(struct.unpack_from("<Q", b, 44)[0]), "event_timer_block_id": hex(struct.unpack_from("<I", b, 36)[0])}

# kernel vs firmware cross-check
facts = json.load(open(FACTS))
apic = {}
cur = {}
for blk in open("/proc/cpuinfo").read().split("\n\n"):
    kv = {k.strip(): v.strip() for k, v in (l.split(":", 1) for l in blk.splitlines() if ":" in l)}
    if "processor" in kv:
        cur[int(kv["processor"])] = int(kv["apicid"])
mismatch = []
for cpu, a in cur.items():
    kdom = facts["cpu_topology"][str(cpu)]["numa"]
    fdom = cpu_dom.get(a)
    if kdom != fdom:
        mismatch.append({"cpu": cpu, "apicid": a, "kernel_node": kdom, "srat_domain": fdom})
res["crosscheck"] = {
    "cpu_numa_kernel_vs_srat_mismatches": mismatch,
    "kernel_cpus": len(cur),
    "srat_enabled_entries": len(cpu_dom),
    "slit_vs_kernel_distance_equal": res["slit"]["matrix"] == [facts["numa"][str(i)]["distance"] for i in range(n)],
    "srat_mem_gib_vs_kernel_memtotal_gib": {str(k): [v / 2**30, facts["numa"][str(k)]["mem_total_kb"] / 2**20] for k, v in dm.items()},
    "apic_ids_firmware_not_in_kernel": sorted(set(ids) - set(cur.values())),
    "apic_ids_kernel_not_in_firmware": sorted(set(cur.values()) - set(ids)),
}
json.dump(res, open(OUT, "w"), indent=1)
print(json.dumps(res, indent=1)[:6000])
