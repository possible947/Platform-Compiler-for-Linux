/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20260930 (64-bit version)
 * Copyright (c) 2000 - 2026 Intel Corporation
 * 
 * Disassembly of ../../../ACPI/SRAT.aml
 *
 * ACPI Data Table [SRAT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "SRAT"    [System Resource Affinity Table]
[004h 0004 004h]                Table Length : 000016B0
[008h 0008 001h]                    Revision : 03
[009h 0009 001h]                    Checksum : 94
[00Ah 0010 006h]                      Oem ID : "ALASKA"
[010h 0016 008h]                Oem Table ID : "A M I "
[018h 0024 004h]                Oem Revision : 00000002
[01Ch 0028 004h]             Asl Compiler ID : "INTL"
[020h 0032 004h]       Asl Compiler Revision : 20091013

[024h 0036 004h]              Table Revision : 00000001
[028h 0040 008h]                    Reserved : 0000000000000000

[030h 0048 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[031h 0049 001h]                      Length : 10

[032h 0050 001h]     Proximity Domain Low(8) : 00
[033h 0051 001h]                     Apic ID : 00
[034h 0052 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[038h 0056 001h]             Local Sapic EID : 00
[039h 0057 003h]   Proximity Domain High(24) : 000000
[03Ch 0060 004h]                Clock Domain : 00000000

[040h 0064 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[041h 0065 001h]                      Length : 10

[042h 0066 001h]     Proximity Domain Low(8) : 00
[043h 0067 001h]                     Apic ID : 02
[044h 0068 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[048h 0072 001h]             Local Sapic EID : 00
[049h 0073 003h]   Proximity Domain High(24) : 000000
[04Ch 0076 004h]                Clock Domain : 00000000

[050h 0080 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[051h 0081 001h]                      Length : 10

[052h 0082 001h]     Proximity Domain Low(8) : 00
[053h 0083 001h]                     Apic ID : 04
[054h 0084 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[058h 0088 001h]             Local Sapic EID : 00
[059h 0089 003h]   Proximity Domain High(24) : 000000
[05Ch 0092 004h]                Clock Domain : 00000000

[060h 0096 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[061h 0097 001h]                      Length : 10

[062h 0098 001h]     Proximity Domain Low(8) : 00
[063h 0099 001h]                     Apic ID : 06
[064h 0100 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[068h 0104 001h]             Local Sapic EID : 00
[069h 0105 003h]   Proximity Domain High(24) : 000000
[06Ch 0108 004h]                Clock Domain : 00000000

[070h 0112 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[071h 0113 001h]                      Length : 10

[072h 0114 001h]     Proximity Domain Low(8) : 00
[073h 0115 001h]                     Apic ID : 08
[074h 0116 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[078h 0120 001h]             Local Sapic EID : 00
[079h 0121 003h]   Proximity Domain High(24) : 000000
[07Ch 0124 004h]                Clock Domain : 00000000

[080h 0128 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[081h 0129 001h]                      Length : 10

[082h 0130 001h]     Proximity Domain Low(8) : 00
[083h 0131 001h]                     Apic ID : 10
[084h 0132 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[088h 0136 001h]             Local Sapic EID : 00
[089h 0137 003h]   Proximity Domain High(24) : 000000
[08Ch 0140 004h]                Clock Domain : 00000000

[090h 0144 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[091h 0145 001h]                      Length : 10

[092h 0146 001h]     Proximity Domain Low(8) : 00
[093h 0147 001h]                     Apic ID : 12
[094h 0148 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[098h 0152 001h]             Local Sapic EID : 00
[099h 0153 003h]   Proximity Domain High(24) : 000000
[09Ch 0156 004h]                Clock Domain : 00000000

[0A0h 0160 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[0A1h 0161 001h]                      Length : 10

[0A2h 0162 001h]     Proximity Domain Low(8) : 00
[0A3h 0163 001h]                     Apic ID : 14
[0A4h 0164 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[0A8h 0168 001h]             Local Sapic EID : 00
[0A9h 0169 003h]   Proximity Domain High(24) : 000000
[0ACh 0172 004h]                Clock Domain : 00000000

[0B0h 0176 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[0B1h 0177 001h]                      Length : 10

[0B2h 0178 001h]     Proximity Domain Low(8) : 00
[0B3h 0179 001h]                     Apic ID : 16
[0B4h 0180 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[0B8h 0184 001h]             Local Sapic EID : 00
[0B9h 0185 003h]   Proximity Domain High(24) : 000000
[0BCh 0188 004h]                Clock Domain : 00000000

[0C0h 0192 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[0C1h 0193 001h]                      Length : 10

[0C2h 0194 001h]     Proximity Domain Low(8) : 00
[0C3h 0195 001h]                     Apic ID : 18
[0C4h 0196 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[0C8h 0200 001h]             Local Sapic EID : 00
[0C9h 0201 003h]   Proximity Domain High(24) : 000000
[0CCh 0204 004h]                Clock Domain : 00000000

[0D0h 0208 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[0D1h 0209 001h]                      Length : 10

[0D2h 0210 001h]     Proximity Domain Low(8) : 00
[0D3h 0211 001h]                     Apic ID : 20
[0D4h 0212 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[0D8h 0216 001h]             Local Sapic EID : 00
[0D9h 0217 003h]   Proximity Domain High(24) : 000000
[0DCh 0220 004h]                Clock Domain : 00000000

[0E0h 0224 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[0E1h 0225 001h]                      Length : 10

[0E2h 0226 001h]     Proximity Domain Low(8) : 00
[0E3h 0227 001h]                     Apic ID : 22
[0E4h 0228 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[0E8h 0232 001h]             Local Sapic EID : 00
[0E9h 0233 003h]   Proximity Domain High(24) : 000000
[0ECh 0236 004h]                Clock Domain : 00000000

[0F0h 0240 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[0F1h 0241 001h]                      Length : 10

[0F2h 0242 001h]     Proximity Domain Low(8) : 00
[0F3h 0243 001h]                     Apic ID : 24
[0F4h 0244 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[0F8h 0248 001h]             Local Sapic EID : 00
[0F9h 0249 003h]   Proximity Domain High(24) : 000000
[0FCh 0252 004h]                Clock Domain : 00000000

[100h 0256 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[101h 0257 001h]                      Length : 10

[102h 0258 001h]     Proximity Domain Low(8) : 00
[103h 0259 001h]                     Apic ID : 26
[104h 0260 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[108h 0264 001h]             Local Sapic EID : 00
[109h 0265 003h]   Proximity Domain High(24) : 000000
[10Ch 0268 004h]                Clock Domain : 00000000

[110h 0272 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[111h 0273 001h]                      Length : 10

[112h 0274 001h]     Proximity Domain Low(8) : 00
[113h 0275 001h]                     Apic ID : 28
[114h 0276 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[118h 0280 001h]             Local Sapic EID : 00
[119h 0281 003h]   Proximity Domain High(24) : 000000
[11Ch 0284 004h]                Clock Domain : 00000000

[120h 0288 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[121h 0289 001h]                      Length : 10

[122h 0290 001h]     Proximity Domain Low(8) : 00
[123h 0291 001h]                     Apic ID : 30
[124h 0292 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[128h 0296 001h]             Local Sapic EID : 00
[129h 0297 003h]   Proximity Domain High(24) : 000000
[12Ch 0300 004h]                Clock Domain : 00000000

[130h 0304 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[131h 0305 001h]                      Length : 10

[132h 0306 001h]     Proximity Domain Low(8) : 00
[133h 0307 001h]                     Apic ID : 32
[134h 0308 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[138h 0312 001h]             Local Sapic EID : 00
[139h 0313 003h]   Proximity Domain High(24) : 000000
[13Ch 0316 004h]                Clock Domain : 00000000

[140h 0320 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[141h 0321 001h]                      Length : 10

[142h 0322 001h]     Proximity Domain Low(8) : 00
[143h 0323 001h]                     Apic ID : 34
[144h 0324 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[148h 0328 001h]             Local Sapic EID : 00
[149h 0329 003h]   Proximity Domain High(24) : 000000
[14Ch 0332 004h]                Clock Domain : 00000000

[150h 0336 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[151h 0337 001h]                      Length : 10

[152h 0338 001h]     Proximity Domain Low(8) : 00
[153h 0339 001h]                     Apic ID : 36
[154h 0340 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[158h 0344 001h]             Local Sapic EID : 00
[159h 0345 003h]   Proximity Domain High(24) : 000000
[15Ch 0348 004h]                Clock Domain : 00000000

[160h 0352 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[161h 0353 001h]                      Length : 10

[162h 0354 001h]     Proximity Domain Low(8) : 00
[163h 0355 001h]                     Apic ID : 38
[164h 0356 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[168h 0360 001h]             Local Sapic EID : 00
[169h 0361 003h]   Proximity Domain High(24) : 000000
[16Ch 0364 004h]                Clock Domain : 00000000

[170h 0368 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[171h 0369 001h]                      Length : 10

[172h 0370 001h]     Proximity Domain Low(8) : 01
[173h 0371 001h]                     Apic ID : 40
[174h 0372 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[178h 0376 001h]             Local Sapic EID : 00
[179h 0377 003h]   Proximity Domain High(24) : 000000
[17Ch 0380 004h]                Clock Domain : 00000000

[180h 0384 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[181h 0385 001h]                      Length : 10

[182h 0386 001h]     Proximity Domain Low(8) : 01
[183h 0387 001h]                     Apic ID : 42
[184h 0388 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[188h 0392 001h]             Local Sapic EID : 00
[189h 0393 003h]   Proximity Domain High(24) : 000000
[18Ch 0396 004h]                Clock Domain : 00000000

[190h 0400 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[191h 0401 001h]                      Length : 10

[192h 0402 001h]     Proximity Domain Low(8) : 01
[193h 0403 001h]                     Apic ID : 44
[194h 0404 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[198h 0408 001h]             Local Sapic EID : 00
[199h 0409 003h]   Proximity Domain High(24) : 000000
[19Ch 0412 004h]                Clock Domain : 00000000

[1A0h 0416 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[1A1h 0417 001h]                      Length : 10

[1A2h 0418 001h]     Proximity Domain Low(8) : 01
[1A3h 0419 001h]                     Apic ID : 46
[1A4h 0420 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[1A8h 0424 001h]             Local Sapic EID : 00
[1A9h 0425 003h]   Proximity Domain High(24) : 000000
[1ACh 0428 004h]                Clock Domain : 00000000

[1B0h 0432 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[1B1h 0433 001h]                      Length : 10

[1B2h 0434 001h]     Proximity Domain Low(8) : 01
[1B3h 0435 001h]                     Apic ID : 48
[1B4h 0436 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[1B8h 0440 001h]             Local Sapic EID : 00
[1B9h 0441 003h]   Proximity Domain High(24) : 000000
[1BCh 0444 004h]                Clock Domain : 00000000

[1C0h 0448 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[1C1h 0449 001h]                      Length : 10

[1C2h 0450 001h]     Proximity Domain Low(8) : 01
[1C3h 0451 001h]                     Apic ID : 50
[1C4h 0452 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[1C8h 0456 001h]             Local Sapic EID : 00
[1C9h 0457 003h]   Proximity Domain High(24) : 000000
[1CCh 0460 004h]                Clock Domain : 00000000

[1D0h 0464 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[1D1h 0465 001h]                      Length : 10

[1D2h 0466 001h]     Proximity Domain Low(8) : 01
[1D3h 0467 001h]                     Apic ID : 52
[1D4h 0468 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[1D8h 0472 001h]             Local Sapic EID : 00
[1D9h 0473 003h]   Proximity Domain High(24) : 000000
[1DCh 0476 004h]                Clock Domain : 00000000

[1E0h 0480 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[1E1h 0481 001h]                      Length : 10

[1E2h 0482 001h]     Proximity Domain Low(8) : 01
[1E3h 0483 001h]                     Apic ID : 54
[1E4h 0484 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[1E8h 0488 001h]             Local Sapic EID : 00
[1E9h 0489 003h]   Proximity Domain High(24) : 000000
[1ECh 0492 004h]                Clock Domain : 00000000

[1F0h 0496 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[1F1h 0497 001h]                      Length : 10

[1F2h 0498 001h]     Proximity Domain Low(8) : 01
[1F3h 0499 001h]                     Apic ID : 56
[1F4h 0500 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[1F8h 0504 001h]             Local Sapic EID : 00
[1F9h 0505 003h]   Proximity Domain High(24) : 000000
[1FCh 0508 004h]                Clock Domain : 00000000

[200h 0512 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[201h 0513 001h]                      Length : 10

[202h 0514 001h]     Proximity Domain Low(8) : 01
[203h 0515 001h]                     Apic ID : 58
[204h 0516 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[208h 0520 001h]             Local Sapic EID : 00
[209h 0521 003h]   Proximity Domain High(24) : 000000
[20Ch 0524 004h]                Clock Domain : 00000000

[210h 0528 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[211h 0529 001h]                      Length : 10

[212h 0530 001h]     Proximity Domain Low(8) : 01
[213h 0531 001h]                     Apic ID : 60
[214h 0532 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[218h 0536 001h]             Local Sapic EID : 00
[219h 0537 003h]   Proximity Domain High(24) : 000000
[21Ch 0540 004h]                Clock Domain : 00000000

[220h 0544 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[221h 0545 001h]                      Length : 10

[222h 0546 001h]     Proximity Domain Low(8) : 01
[223h 0547 001h]                     Apic ID : 62
[224h 0548 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[228h 0552 001h]             Local Sapic EID : 00
[229h 0553 003h]   Proximity Domain High(24) : 000000
[22Ch 0556 004h]                Clock Domain : 00000000

[230h 0560 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[231h 0561 001h]                      Length : 10

[232h 0562 001h]     Proximity Domain Low(8) : 01
[233h 0563 001h]                     Apic ID : 64
[234h 0564 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[238h 0568 001h]             Local Sapic EID : 00
[239h 0569 003h]   Proximity Domain High(24) : 000000
[23Ch 0572 004h]                Clock Domain : 00000000

[240h 0576 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[241h 0577 001h]                      Length : 10

[242h 0578 001h]     Proximity Domain Low(8) : 01
[243h 0579 001h]                     Apic ID : 66
[244h 0580 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[248h 0584 001h]             Local Sapic EID : 00
[249h 0585 003h]   Proximity Domain High(24) : 000000
[24Ch 0588 004h]                Clock Domain : 00000000

[250h 0592 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[251h 0593 001h]                      Length : 10

[252h 0594 001h]     Proximity Domain Low(8) : 01
[253h 0595 001h]                     Apic ID : 68
[254h 0596 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[258h 0600 001h]             Local Sapic EID : 00
[259h 0601 003h]   Proximity Domain High(24) : 000000
[25Ch 0604 004h]                Clock Domain : 00000000

[260h 0608 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[261h 0609 001h]                      Length : 10

[262h 0610 001h]     Proximity Domain Low(8) : 01
[263h 0611 001h]                     Apic ID : 70
[264h 0612 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[268h 0616 001h]             Local Sapic EID : 00
[269h 0617 003h]   Proximity Domain High(24) : 000000
[26Ch 0620 004h]                Clock Domain : 00000000

[270h 0624 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[271h 0625 001h]                      Length : 10

[272h 0626 001h]     Proximity Domain Low(8) : 01
[273h 0627 001h]                     Apic ID : 72
[274h 0628 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[278h 0632 001h]             Local Sapic EID : 00
[279h 0633 003h]   Proximity Domain High(24) : 000000
[27Ch 0636 004h]                Clock Domain : 00000000

[280h 0640 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[281h 0641 001h]                      Length : 10

[282h 0642 001h]     Proximity Domain Low(8) : 01
[283h 0643 001h]                     Apic ID : 74
[284h 0644 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[288h 0648 001h]             Local Sapic EID : 00
[289h 0649 003h]   Proximity Domain High(24) : 000000
[28Ch 0652 004h]                Clock Domain : 00000000

[290h 0656 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[291h 0657 001h]                      Length : 10

[292h 0658 001h]     Proximity Domain Low(8) : 01
[293h 0659 001h]                     Apic ID : 76
[294h 0660 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[298h 0664 001h]             Local Sapic EID : 00
[299h 0665 003h]   Proximity Domain High(24) : 000000
[29Ch 0668 004h]                Clock Domain : 00000000

[2A0h 0672 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[2A1h 0673 001h]                      Length : 10

[2A2h 0674 001h]     Proximity Domain Low(8) : 01
[2A3h 0675 001h]                     Apic ID : 78
[2A4h 0676 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[2A8h 0680 001h]             Local Sapic EID : 00
[2A9h 0681 003h]   Proximity Domain High(24) : 000000
[2ACh 0684 004h]                Clock Domain : 00000000

[2B0h 0688 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[2B1h 0689 001h]                      Length : 10

[2B2h 0690 001h]     Proximity Domain Low(8) : 00
[2B3h 0691 001h]                     Apic ID : 01
[2B4h 0692 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[2B8h 0696 001h]             Local Sapic EID : 00
[2B9h 0697 003h]   Proximity Domain High(24) : 000000
[2BCh 0700 004h]                Clock Domain : 00000000

[2C0h 0704 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[2C1h 0705 001h]                      Length : 10

[2C2h 0706 001h]     Proximity Domain Low(8) : 00
[2C3h 0707 001h]                     Apic ID : 03
[2C4h 0708 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[2C8h 0712 001h]             Local Sapic EID : 00
[2C9h 0713 003h]   Proximity Domain High(24) : 000000
[2CCh 0716 004h]                Clock Domain : 00000000

[2D0h 0720 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[2D1h 0721 001h]                      Length : 10

[2D2h 0722 001h]     Proximity Domain Low(8) : 00
[2D3h 0723 001h]                     Apic ID : 05
[2D4h 0724 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[2D8h 0728 001h]             Local Sapic EID : 00
[2D9h 0729 003h]   Proximity Domain High(24) : 000000
[2DCh 0732 004h]                Clock Domain : 00000000

[2E0h 0736 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[2E1h 0737 001h]                      Length : 10

[2E2h 0738 001h]     Proximity Domain Low(8) : 00
[2E3h 0739 001h]                     Apic ID : 07
[2E4h 0740 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[2E8h 0744 001h]             Local Sapic EID : 00
[2E9h 0745 003h]   Proximity Domain High(24) : 000000
[2ECh 0748 004h]                Clock Domain : 00000000

[2F0h 0752 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[2F1h 0753 001h]                      Length : 10

[2F2h 0754 001h]     Proximity Domain Low(8) : 00
[2F3h 0755 001h]                     Apic ID : 09
[2F4h 0756 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[2F8h 0760 001h]             Local Sapic EID : 00
[2F9h 0761 003h]   Proximity Domain High(24) : 000000
[2FCh 0764 004h]                Clock Domain : 00000000

[300h 0768 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[301h 0769 001h]                      Length : 10

[302h 0770 001h]     Proximity Domain Low(8) : 00
[303h 0771 001h]                     Apic ID : 11
[304h 0772 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[308h 0776 001h]             Local Sapic EID : 00
[309h 0777 003h]   Proximity Domain High(24) : 000000
[30Ch 0780 004h]                Clock Domain : 00000000

[310h 0784 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[311h 0785 001h]                      Length : 10

[312h 0786 001h]     Proximity Domain Low(8) : 00
[313h 0787 001h]                     Apic ID : 13
[314h 0788 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[318h 0792 001h]             Local Sapic EID : 00
[319h 0793 003h]   Proximity Domain High(24) : 000000
[31Ch 0796 004h]                Clock Domain : 00000000

[320h 0800 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[321h 0801 001h]                      Length : 10

[322h 0802 001h]     Proximity Domain Low(8) : 00
[323h 0803 001h]                     Apic ID : 15
[324h 0804 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[328h 0808 001h]             Local Sapic EID : 00
[329h 0809 003h]   Proximity Domain High(24) : 000000
[32Ch 0812 004h]                Clock Domain : 00000000

[330h 0816 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[331h 0817 001h]                      Length : 10

[332h 0818 001h]     Proximity Domain Low(8) : 00
[333h 0819 001h]                     Apic ID : 17
[334h 0820 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[338h 0824 001h]             Local Sapic EID : 00
[339h 0825 003h]   Proximity Domain High(24) : 000000
[33Ch 0828 004h]                Clock Domain : 00000000

[340h 0832 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[341h 0833 001h]                      Length : 10

[342h 0834 001h]     Proximity Domain Low(8) : 00
[343h 0835 001h]                     Apic ID : 19
[344h 0836 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[348h 0840 001h]             Local Sapic EID : 00
[349h 0841 003h]   Proximity Domain High(24) : 000000
[34Ch 0844 004h]                Clock Domain : 00000000

[350h 0848 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[351h 0849 001h]                      Length : 10

[352h 0850 001h]     Proximity Domain Low(8) : 00
[353h 0851 001h]                     Apic ID : 21
[354h 0852 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[358h 0856 001h]             Local Sapic EID : 00
[359h 0857 003h]   Proximity Domain High(24) : 000000
[35Ch 0860 004h]                Clock Domain : 00000000

[360h 0864 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[361h 0865 001h]                      Length : 10

[362h 0866 001h]     Proximity Domain Low(8) : 00
[363h 0867 001h]                     Apic ID : 23
[364h 0868 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[368h 0872 001h]             Local Sapic EID : 00
[369h 0873 003h]   Proximity Domain High(24) : 000000
[36Ch 0876 004h]                Clock Domain : 00000000

[370h 0880 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[371h 0881 001h]                      Length : 10

[372h 0882 001h]     Proximity Domain Low(8) : 00
[373h 0883 001h]                     Apic ID : 25
[374h 0884 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[378h 0888 001h]             Local Sapic EID : 00
[379h 0889 003h]   Proximity Domain High(24) : 000000
[37Ch 0892 004h]                Clock Domain : 00000000

[380h 0896 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[381h 0897 001h]                      Length : 10

[382h 0898 001h]     Proximity Domain Low(8) : 00
[383h 0899 001h]                     Apic ID : 27
[384h 0900 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[388h 0904 001h]             Local Sapic EID : 00
[389h 0905 003h]   Proximity Domain High(24) : 000000
[38Ch 0908 004h]                Clock Domain : 00000000

[390h 0912 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[391h 0913 001h]                      Length : 10

[392h 0914 001h]     Proximity Domain Low(8) : 00
[393h 0915 001h]                     Apic ID : 29
[394h 0916 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[398h 0920 001h]             Local Sapic EID : 00
[399h 0921 003h]   Proximity Domain High(24) : 000000
[39Ch 0924 004h]                Clock Domain : 00000000

[3A0h 0928 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[3A1h 0929 001h]                      Length : 10

[3A2h 0930 001h]     Proximity Domain Low(8) : 00
[3A3h 0931 001h]                     Apic ID : 31
[3A4h 0932 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[3A8h 0936 001h]             Local Sapic EID : 00
[3A9h 0937 003h]   Proximity Domain High(24) : 000000
[3ACh 0940 004h]                Clock Domain : 00000000

[3B0h 0944 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[3B1h 0945 001h]                      Length : 10

[3B2h 0946 001h]     Proximity Domain Low(8) : 00
[3B3h 0947 001h]                     Apic ID : 33
[3B4h 0948 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[3B8h 0952 001h]             Local Sapic EID : 00
[3B9h 0953 003h]   Proximity Domain High(24) : 000000
[3BCh 0956 004h]                Clock Domain : 00000000

[3C0h 0960 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[3C1h 0961 001h]                      Length : 10

[3C2h 0962 001h]     Proximity Domain Low(8) : 00
[3C3h 0963 001h]                     Apic ID : 35
[3C4h 0964 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[3C8h 0968 001h]             Local Sapic EID : 00
[3C9h 0969 003h]   Proximity Domain High(24) : 000000
[3CCh 0972 004h]                Clock Domain : 00000000

[3D0h 0976 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[3D1h 0977 001h]                      Length : 10

[3D2h 0978 001h]     Proximity Domain Low(8) : 00
[3D3h 0979 001h]                     Apic ID : 37
[3D4h 0980 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[3D8h 0984 001h]             Local Sapic EID : 00
[3D9h 0985 003h]   Proximity Domain High(24) : 000000
[3DCh 0988 004h]                Clock Domain : 00000000

[3E0h 0992 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[3E1h 0993 001h]                      Length : 10

[3E2h 0994 001h]     Proximity Domain Low(8) : 00
[3E3h 0995 001h]                     Apic ID : 39
[3E4h 0996 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[3E8h 1000 001h]             Local Sapic EID : 00
[3E9h 1001 003h]   Proximity Domain High(24) : 000000
[3ECh 1004 004h]                Clock Domain : 00000000

[3F0h 1008 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[3F1h 1009 001h]                      Length : 10

[3F2h 1010 001h]     Proximity Domain Low(8) : 01
[3F3h 1011 001h]                     Apic ID : 41
[3F4h 1012 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[3F8h 1016 001h]             Local Sapic EID : 00
[3F9h 1017 003h]   Proximity Domain High(24) : 000000
[3FCh 1020 004h]                Clock Domain : 00000000

[400h 1024 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[401h 1025 001h]                      Length : 10

[402h 1026 001h]     Proximity Domain Low(8) : 01
[403h 1027 001h]                     Apic ID : 43
[404h 1028 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[408h 1032 001h]             Local Sapic EID : 00
[409h 1033 003h]   Proximity Domain High(24) : 000000
[40Ch 1036 004h]                Clock Domain : 00000000

[410h 1040 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[411h 1041 001h]                      Length : 10

[412h 1042 001h]     Proximity Domain Low(8) : 01
[413h 1043 001h]                     Apic ID : 45
[414h 1044 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[418h 1048 001h]             Local Sapic EID : 00
[419h 1049 003h]   Proximity Domain High(24) : 000000
[41Ch 1052 004h]                Clock Domain : 00000000

[420h 1056 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[421h 1057 001h]                      Length : 10

[422h 1058 001h]     Proximity Domain Low(8) : 01
[423h 1059 001h]                     Apic ID : 47
[424h 1060 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[428h 1064 001h]             Local Sapic EID : 00
[429h 1065 003h]   Proximity Domain High(24) : 000000
[42Ch 1068 004h]                Clock Domain : 00000000

[430h 1072 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[431h 1073 001h]                      Length : 10

[432h 1074 001h]     Proximity Domain Low(8) : 01
[433h 1075 001h]                     Apic ID : 49
[434h 1076 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[438h 1080 001h]             Local Sapic EID : 00
[439h 1081 003h]   Proximity Domain High(24) : 000000
[43Ch 1084 004h]                Clock Domain : 00000000

[440h 1088 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[441h 1089 001h]                      Length : 10

[442h 1090 001h]     Proximity Domain Low(8) : 01
[443h 1091 001h]                     Apic ID : 51
[444h 1092 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[448h 1096 001h]             Local Sapic EID : 00
[449h 1097 003h]   Proximity Domain High(24) : 000000
[44Ch 1100 004h]                Clock Domain : 00000000

[450h 1104 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[451h 1105 001h]                      Length : 10

[452h 1106 001h]     Proximity Domain Low(8) : 01
[453h 1107 001h]                     Apic ID : 53
[454h 1108 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[458h 1112 001h]             Local Sapic EID : 00
[459h 1113 003h]   Proximity Domain High(24) : 000000
[45Ch 1116 004h]                Clock Domain : 00000000

[460h 1120 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[461h 1121 001h]                      Length : 10

[462h 1122 001h]     Proximity Domain Low(8) : 01
[463h 1123 001h]                     Apic ID : 55
[464h 1124 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[468h 1128 001h]             Local Sapic EID : 00
[469h 1129 003h]   Proximity Domain High(24) : 000000
[46Ch 1132 004h]                Clock Domain : 00000000

[470h 1136 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[471h 1137 001h]                      Length : 10

[472h 1138 001h]     Proximity Domain Low(8) : 01
[473h 1139 001h]                     Apic ID : 57
[474h 1140 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[478h 1144 001h]             Local Sapic EID : 00
[479h 1145 003h]   Proximity Domain High(24) : 000000
[47Ch 1148 004h]                Clock Domain : 00000000

[480h 1152 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[481h 1153 001h]                      Length : 10

[482h 1154 001h]     Proximity Domain Low(8) : 01
[483h 1155 001h]                     Apic ID : 59
[484h 1156 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[488h 1160 001h]             Local Sapic EID : 00
[489h 1161 003h]   Proximity Domain High(24) : 000000
[48Ch 1164 004h]                Clock Domain : 00000000

[490h 1168 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[491h 1169 001h]                      Length : 10

[492h 1170 001h]     Proximity Domain Low(8) : 01
[493h 1171 001h]                     Apic ID : 61
[494h 1172 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[498h 1176 001h]             Local Sapic EID : 00
[499h 1177 003h]   Proximity Domain High(24) : 000000
[49Ch 1180 004h]                Clock Domain : 00000000

[4A0h 1184 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[4A1h 1185 001h]                      Length : 10

[4A2h 1186 001h]     Proximity Domain Low(8) : 01
[4A3h 1187 001h]                     Apic ID : 63
[4A4h 1188 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[4A8h 1192 001h]             Local Sapic EID : 00
[4A9h 1193 003h]   Proximity Domain High(24) : 000000
[4ACh 1196 004h]                Clock Domain : 00000000

[4B0h 1200 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[4B1h 1201 001h]                      Length : 10

[4B2h 1202 001h]     Proximity Domain Low(8) : 01
[4B3h 1203 001h]                     Apic ID : 65
[4B4h 1204 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[4B8h 1208 001h]             Local Sapic EID : 00
[4B9h 1209 003h]   Proximity Domain High(24) : 000000
[4BCh 1212 004h]                Clock Domain : 00000000

[4C0h 1216 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[4C1h 1217 001h]                      Length : 10

[4C2h 1218 001h]     Proximity Domain Low(8) : 01
[4C3h 1219 001h]                     Apic ID : 67
[4C4h 1220 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[4C8h 1224 001h]             Local Sapic EID : 00
[4C9h 1225 003h]   Proximity Domain High(24) : 000000
[4CCh 1228 004h]                Clock Domain : 00000000

[4D0h 1232 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[4D1h 1233 001h]                      Length : 10

[4D2h 1234 001h]     Proximity Domain Low(8) : 01
[4D3h 1235 001h]                     Apic ID : 69
[4D4h 1236 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[4D8h 1240 001h]             Local Sapic EID : 00
[4D9h 1241 003h]   Proximity Domain High(24) : 000000
[4DCh 1244 004h]                Clock Domain : 00000000

[4E0h 1248 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[4E1h 1249 001h]                      Length : 10

[4E2h 1250 001h]     Proximity Domain Low(8) : 01
[4E3h 1251 001h]                     Apic ID : 71
[4E4h 1252 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[4E8h 1256 001h]             Local Sapic EID : 00
[4E9h 1257 003h]   Proximity Domain High(24) : 000000
[4ECh 1260 004h]                Clock Domain : 00000000

[4F0h 1264 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[4F1h 1265 001h]                      Length : 10

[4F2h 1266 001h]     Proximity Domain Low(8) : 01
[4F3h 1267 001h]                     Apic ID : 73
[4F4h 1268 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[4F8h 1272 001h]             Local Sapic EID : 00
[4F9h 1273 003h]   Proximity Domain High(24) : 000000
[4FCh 1276 004h]                Clock Domain : 00000000

[500h 1280 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[501h 1281 001h]                      Length : 10

[502h 1282 001h]     Proximity Domain Low(8) : 01
[503h 1283 001h]                     Apic ID : 75
[504h 1284 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[508h 1288 001h]             Local Sapic EID : 00
[509h 1289 003h]   Proximity Domain High(24) : 000000
[50Ch 1292 004h]                Clock Domain : 00000000

[510h 1296 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[511h 1297 001h]                      Length : 10

[512h 1298 001h]     Proximity Domain Low(8) : 01
[513h 1299 001h]                     Apic ID : 77
[514h 1300 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[518h 1304 001h]             Local Sapic EID : 00
[519h 1305 003h]   Proximity Domain High(24) : 000000
[51Ch 1308 004h]                Clock Domain : 00000000

[520h 1312 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[521h 1313 001h]                      Length : 10

[522h 1314 001h]     Proximity Domain Low(8) : 01
[523h 1315 001h]                     Apic ID : 79
[524h 1316 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[528h 1320 001h]             Local Sapic EID : 00
[529h 1321 003h]   Proximity Domain High(24) : 000000
[52Ch 1324 004h]                Clock Domain : 00000000

[530h 1328 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[531h 1329 001h]                      Length : 10

[532h 1330 001h]     Proximity Domain Low(8) : 00
[533h 1331 001h]                     Apic ID : FF
[534h 1332 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[538h 1336 001h]             Local Sapic EID : 00
[539h 1337 003h]   Proximity Domain High(24) : 000000
[53Ch 1340 004h]                Clock Domain : 00000000

[540h 1344 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[541h 1345 001h]                      Length : 10

[542h 1346 001h]     Proximity Domain Low(8) : 00
[543h 1347 001h]                     Apic ID : FF
[544h 1348 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[548h 1352 001h]             Local Sapic EID : 00
[549h 1353 003h]   Proximity Domain High(24) : 000000
[54Ch 1356 004h]                Clock Domain : 00000000

[550h 1360 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[551h 1361 001h]                      Length : 10

[552h 1362 001h]     Proximity Domain Low(8) : 00
[553h 1363 001h]                     Apic ID : FF
[554h 1364 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[558h 1368 001h]             Local Sapic EID : 00
[559h 1369 003h]   Proximity Domain High(24) : 000000
[55Ch 1372 004h]                Clock Domain : 00000000

[560h 1376 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[561h 1377 001h]                      Length : 10

[562h 1378 001h]     Proximity Domain Low(8) : 00
[563h 1379 001h]                     Apic ID : FF
[564h 1380 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[568h 1384 001h]             Local Sapic EID : 00
[569h 1385 003h]   Proximity Domain High(24) : 000000
[56Ch 1388 004h]                Clock Domain : 00000000

[570h 1392 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[571h 1393 001h]                      Length : 10

[572h 1394 001h]     Proximity Domain Low(8) : 00
[573h 1395 001h]                     Apic ID : FF
[574h 1396 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[578h 1400 001h]             Local Sapic EID : 00
[579h 1401 003h]   Proximity Domain High(24) : 000000
[57Ch 1404 004h]                Clock Domain : 00000000

[580h 1408 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[581h 1409 001h]                      Length : 10

[582h 1410 001h]     Proximity Domain Low(8) : 00
[583h 1411 001h]                     Apic ID : FF
[584h 1412 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[588h 1416 001h]             Local Sapic EID : 00
[589h 1417 003h]   Proximity Domain High(24) : 000000
[58Ch 1420 004h]                Clock Domain : 00000000

[590h 1424 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[591h 1425 001h]                      Length : 10

[592h 1426 001h]     Proximity Domain Low(8) : 00
[593h 1427 001h]                     Apic ID : FF
[594h 1428 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[598h 1432 001h]             Local Sapic EID : 00
[599h 1433 003h]   Proximity Domain High(24) : 000000
[59Ch 1436 004h]                Clock Domain : 00000000

[5A0h 1440 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[5A1h 1441 001h]                      Length : 10

[5A2h 1442 001h]     Proximity Domain Low(8) : 00
[5A3h 1443 001h]                     Apic ID : FF
[5A4h 1444 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[5A8h 1448 001h]             Local Sapic EID : 00
[5A9h 1449 003h]   Proximity Domain High(24) : 000000
[5ACh 1452 004h]                Clock Domain : 00000000

[5B0h 1456 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[5B1h 1457 001h]                      Length : 10

[5B2h 1458 001h]     Proximity Domain Low(8) : 00
[5B3h 1459 001h]                     Apic ID : FF
[5B4h 1460 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[5B8h 1464 001h]             Local Sapic EID : 00
[5B9h 1465 003h]   Proximity Domain High(24) : 000000
[5BCh 1468 004h]                Clock Domain : 00000000

[5C0h 1472 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[5C1h 1473 001h]                      Length : 10

[5C2h 1474 001h]     Proximity Domain Low(8) : 00
[5C3h 1475 001h]                     Apic ID : FF
[5C4h 1476 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[5C8h 1480 001h]             Local Sapic EID : 00
[5C9h 1481 003h]   Proximity Domain High(24) : 000000
[5CCh 1484 004h]                Clock Domain : 00000000

[5D0h 1488 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[5D1h 1489 001h]                      Length : 10

[5D2h 1490 001h]     Proximity Domain Low(8) : 00
[5D3h 1491 001h]                     Apic ID : FF
[5D4h 1492 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[5D8h 1496 001h]             Local Sapic EID : 00
[5D9h 1497 003h]   Proximity Domain High(24) : 000000
[5DCh 1500 004h]                Clock Domain : 00000000

[5E0h 1504 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[5E1h 1505 001h]                      Length : 10

[5E2h 1506 001h]     Proximity Domain Low(8) : 00
[5E3h 1507 001h]                     Apic ID : FF
[5E4h 1508 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[5E8h 1512 001h]             Local Sapic EID : 00
[5E9h 1513 003h]   Proximity Domain High(24) : 000000
[5ECh 1516 004h]                Clock Domain : 00000000

[5F0h 1520 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[5F1h 1521 001h]                      Length : 10

[5F2h 1522 001h]     Proximity Domain Low(8) : 00
[5F3h 1523 001h]                     Apic ID : FF
[5F4h 1524 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[5F8h 1528 001h]             Local Sapic EID : 00
[5F9h 1529 003h]   Proximity Domain High(24) : 000000
[5FCh 1532 004h]                Clock Domain : 00000000

[600h 1536 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[601h 1537 001h]                      Length : 10

[602h 1538 001h]     Proximity Domain Low(8) : 00
[603h 1539 001h]                     Apic ID : FF
[604h 1540 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[608h 1544 001h]             Local Sapic EID : 00
[609h 1545 003h]   Proximity Domain High(24) : 000000
[60Ch 1548 004h]                Clock Domain : 00000000

[610h 1552 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[611h 1553 001h]                      Length : 10

[612h 1554 001h]     Proximity Domain Low(8) : 00
[613h 1555 001h]                     Apic ID : FF
[614h 1556 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[618h 1560 001h]             Local Sapic EID : 00
[619h 1561 003h]   Proximity Domain High(24) : 000000
[61Ch 1564 004h]                Clock Domain : 00000000

[620h 1568 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[621h 1569 001h]                      Length : 10

[622h 1570 001h]     Proximity Domain Low(8) : 00
[623h 1571 001h]                     Apic ID : FF
[624h 1572 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[628h 1576 001h]             Local Sapic EID : 00
[629h 1577 003h]   Proximity Domain High(24) : 000000
[62Ch 1580 004h]                Clock Domain : 00000000

[630h 1584 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[631h 1585 001h]                      Length : 10

[632h 1586 001h]     Proximity Domain Low(8) : 00
[633h 1587 001h]                     Apic ID : FF
[634h 1588 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[638h 1592 001h]             Local Sapic EID : 00
[639h 1593 003h]   Proximity Domain High(24) : 000000
[63Ch 1596 004h]                Clock Domain : 00000000

[640h 1600 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[641h 1601 001h]                      Length : 10

[642h 1602 001h]     Proximity Domain Low(8) : 00
[643h 1603 001h]                     Apic ID : FF
[644h 1604 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[648h 1608 001h]             Local Sapic EID : 00
[649h 1609 003h]   Proximity Domain High(24) : 000000
[64Ch 1612 004h]                Clock Domain : 00000000

[650h 1616 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[651h 1617 001h]                      Length : 10

[652h 1618 001h]     Proximity Domain Low(8) : 00
[653h 1619 001h]                     Apic ID : FF
[654h 1620 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[658h 1624 001h]             Local Sapic EID : 00
[659h 1625 003h]   Proximity Domain High(24) : 000000
[65Ch 1628 004h]                Clock Domain : 00000000

[660h 1632 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[661h 1633 001h]                      Length : 10

[662h 1634 001h]     Proximity Domain Low(8) : 00
[663h 1635 001h]                     Apic ID : FF
[664h 1636 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[668h 1640 001h]             Local Sapic EID : 00
[669h 1641 003h]   Proximity Domain High(24) : 000000
[66Ch 1644 004h]                Clock Domain : 00000000

[670h 1648 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[671h 1649 001h]                      Length : 10

[672h 1650 001h]     Proximity Domain Low(8) : 00
[673h 1651 001h]                     Apic ID : FF
[674h 1652 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[678h 1656 001h]             Local Sapic EID : 00
[679h 1657 003h]   Proximity Domain High(24) : 000000
[67Ch 1660 004h]                Clock Domain : 00000000

[680h 1664 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[681h 1665 001h]                      Length : 10

[682h 1666 001h]     Proximity Domain Low(8) : 00
[683h 1667 001h]                     Apic ID : FF
[684h 1668 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[688h 1672 001h]             Local Sapic EID : 00
[689h 1673 003h]   Proximity Domain High(24) : 000000
[68Ch 1676 004h]                Clock Domain : 00000000

[690h 1680 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[691h 1681 001h]                      Length : 10

[692h 1682 001h]     Proximity Domain Low(8) : 00
[693h 1683 001h]                     Apic ID : FF
[694h 1684 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[698h 1688 001h]             Local Sapic EID : 00
[699h 1689 003h]   Proximity Domain High(24) : 000000
[69Ch 1692 004h]                Clock Domain : 00000000

[6A0h 1696 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[6A1h 1697 001h]                      Length : 10

[6A2h 1698 001h]     Proximity Domain Low(8) : 00
[6A3h 1699 001h]                     Apic ID : FF
[6A4h 1700 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[6A8h 1704 001h]             Local Sapic EID : 00
[6A9h 1705 003h]   Proximity Domain High(24) : 000000
[6ACh 1708 004h]                Clock Domain : 00000000

[6B0h 1712 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[6B1h 1713 001h]                      Length : 10

[6B2h 1714 001h]     Proximity Domain Low(8) : 00
[6B3h 1715 001h]                     Apic ID : FF
[6B4h 1716 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[6B8h 1720 001h]             Local Sapic EID : 00
[6B9h 1721 003h]   Proximity Domain High(24) : 000000
[6BCh 1724 004h]                Clock Domain : 00000000

[6C0h 1728 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[6C1h 1729 001h]                      Length : 10

[6C2h 1730 001h]     Proximity Domain Low(8) : 00
[6C3h 1731 001h]                     Apic ID : FF
[6C4h 1732 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[6C8h 1736 001h]             Local Sapic EID : 00
[6C9h 1737 003h]   Proximity Domain High(24) : 000000
[6CCh 1740 004h]                Clock Domain : 00000000

[6D0h 1744 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[6D1h 1745 001h]                      Length : 10

[6D2h 1746 001h]     Proximity Domain Low(8) : 00
[6D3h 1747 001h]                     Apic ID : FF
[6D4h 1748 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[6D8h 1752 001h]             Local Sapic EID : 00
[6D9h 1753 003h]   Proximity Domain High(24) : 000000
[6DCh 1756 004h]                Clock Domain : 00000000

[6E0h 1760 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[6E1h 1761 001h]                      Length : 10

[6E2h 1762 001h]     Proximity Domain Low(8) : 00
[6E3h 1763 001h]                     Apic ID : FF
[6E4h 1764 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[6E8h 1768 001h]             Local Sapic EID : 00
[6E9h 1769 003h]   Proximity Domain High(24) : 000000
[6ECh 1772 004h]                Clock Domain : 00000000

[6F0h 1776 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[6F1h 1777 001h]                      Length : 10

[6F2h 1778 001h]     Proximity Domain Low(8) : 00
[6F3h 1779 001h]                     Apic ID : FF
[6F4h 1780 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[6F8h 1784 001h]             Local Sapic EID : 00
[6F9h 1785 003h]   Proximity Domain High(24) : 000000
[6FCh 1788 004h]                Clock Domain : 00000000

[700h 1792 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[701h 1793 001h]                      Length : 10

[702h 1794 001h]     Proximity Domain Low(8) : 00
[703h 1795 001h]                     Apic ID : FF
[704h 1796 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[708h 1800 001h]             Local Sapic EID : 00
[709h 1801 003h]   Proximity Domain High(24) : 000000
[70Ch 1804 004h]                Clock Domain : 00000000

[710h 1808 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[711h 1809 001h]                      Length : 10

[712h 1810 001h]     Proximity Domain Low(8) : 00
[713h 1811 001h]                     Apic ID : FF
[714h 1812 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[718h 1816 001h]             Local Sapic EID : 00
[719h 1817 003h]   Proximity Domain High(24) : 000000
[71Ch 1820 004h]                Clock Domain : 00000000

[720h 1824 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[721h 1825 001h]                      Length : 10

[722h 1826 001h]     Proximity Domain Low(8) : 00
[723h 1827 001h]                     Apic ID : FF
[724h 1828 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[728h 1832 001h]             Local Sapic EID : 00
[729h 1833 003h]   Proximity Domain High(24) : 000000
[72Ch 1836 004h]                Clock Domain : 00000000

[730h 1840 001h]               Subtable Type : 01 [Memory Affinity]
[731h 1841 001h]                      Length : 28

[732h 1842 004h]            Proximity Domain : 00000000
[736h 1846 002h]                   Reserved1 : 0000
[738h 1848 008h]                Base Address : 0000000000000000
[740h 1856 008h]              Address Length : 0000000080000000
[748h 1864 004h]                   Reserved2 : 00000000
[74Ch 1868 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                               Hot Pluggable : 0
                                Non-Volatile : 0
[750h 1872 008h]                   Reserved3 : 0000000000000000

[758h 1880 001h]               Subtable Type : 01 [Memory Affinity]
[759h 1881 001h]                      Length : 28

[75Ah 1882 004h]            Proximity Domain : 00000000
[75Eh 1886 002h]                   Reserved1 : 0000
[760h 1888 008h]                Base Address : 0000000100000000
[768h 1896 008h]              Address Length : 0000000B40000000
[770h 1904 004h]                   Reserved2 : 00000000
[774h 1908 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                               Hot Pluggable : 0
                                Non-Volatile : 0
[778h 1912 008h]                   Reserved3 : 0000000000000000

[780h 1920 001h]               Subtable Type : 01 [Memory Affinity]
[781h 1921 001h]                      Length : 28

[782h 1922 004h]            Proximity Domain : 00000000
[786h 1926 002h]                   Reserved1 : 0000
[788h 1928 008h]                Base Address : 0000000C40000000
[790h 1936 008h]              Address Length : 0000000C00000000
[798h 1944 004h]                   Reserved2 : 00000000
[79Ch 1948 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                               Hot Pluggable : 0
                                Non-Volatile : 0
[7A0h 1952 008h]                   Reserved3 : 0000000000000000

[7A8h 1960 001h]               Subtable Type : 01 [Memory Affinity]
[7A9h 1961 001h]                      Length : 28

[7AAh 1962 004h]            Proximity Domain : 00000001
[7AEh 1966 002h]                   Reserved1 : 0000
[7B0h 1968 008h]                Base Address : 0000001840000000
[7B8h 1976 008h]              Address Length : 0000000C00000000
[7C0h 1984 004h]                   Reserved2 : 00000000
[7C4h 1988 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                               Hot Pluggable : 0
                                Non-Volatile : 0
[7C8h 1992 008h]                   Reserved3 : 0000000000000000

[7D0h 2000 001h]               Subtable Type : 01 [Memory Affinity]
[7D1h 2001 001h]                      Length : 28

[7D2h 2002 004h]            Proximity Domain : 00000001
[7D6h 2006 002h]                   Reserved1 : 0000
[7D8h 2008 008h]                Base Address : 0000002440000000
[7E0h 2016 008h]              Address Length : 0000000C00000000
[7E8h 2024 004h]                   Reserved2 : 00000000
[7ECh 2028 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                               Hot Pluggable : 0
                                Non-Volatile : 0
[7F0h 2032 008h]                   Reserved3 : 0000000000000000

[7F8h 2040 001h]               Subtable Type : 01 [Memory Affinity]
[7F9h 2041 001h]                      Length : 28

[7FAh 2042 004h]            Proximity Domain : 00000000
[7FEh 2046 002h]                   Reserved1 : 0000
[800h 2048 008h]                Base Address : 0000000000000000
[808h 2056 008h]              Address Length : 0000000000000000
[810h 2064 004h]                   Reserved2 : 00000000
[814h 2068 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[818h 2072 008h]                   Reserved3 : 0000000000000000

[820h 2080 001h]               Subtable Type : 01 [Memory Affinity]
[821h 2081 001h]                      Length : 28

[822h 2082 004h]            Proximity Domain : 00000000
[826h 2086 002h]                   Reserved1 : 0000
[828h 2088 008h]                Base Address : 0000000000000000
[830h 2096 008h]              Address Length : 0000000000000000
[838h 2104 004h]                   Reserved2 : 00000000
[83Ch 2108 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[840h 2112 008h]                   Reserved3 : 0000000000000000

[848h 2120 001h]               Subtable Type : 01 [Memory Affinity]
[849h 2121 001h]                      Length : 28

[84Ah 2122 004h]            Proximity Domain : 00000000
[84Eh 2126 002h]                   Reserved1 : 0000
[850h 2128 008h]                Base Address : 0000000000000000
[858h 2136 008h]              Address Length : 0000000000000000
[860h 2144 004h]                   Reserved2 : 00000000
[864h 2148 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[868h 2152 008h]                   Reserved3 : 0000000000000000

[870h 2160 001h]               Subtable Type : 01 [Memory Affinity]
[871h 2161 001h]                      Length : 28

[872h 2162 004h]            Proximity Domain : 00000000
[876h 2166 002h]                   Reserved1 : 0000
[878h 2168 008h]                Base Address : 0000000000000000
[880h 2176 008h]              Address Length : 0000000000000000
[888h 2184 004h]                   Reserved2 : 00000000
[88Ch 2188 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[890h 2192 008h]                   Reserved3 : 0000000000000000

[898h 2200 001h]               Subtable Type : 01 [Memory Affinity]
[899h 2201 001h]                      Length : 28

[89Ah 2202 004h]            Proximity Domain : 00000000
[89Eh 2206 002h]                   Reserved1 : 0000
[8A0h 2208 008h]                Base Address : 0000000000000000
[8A8h 2216 008h]              Address Length : 0000000000000000
[8B0h 2224 004h]                   Reserved2 : 00000000
[8B4h 2228 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[8B8h 2232 008h]                   Reserved3 : 0000000000000000

[8C0h 2240 001h]               Subtable Type : 01 [Memory Affinity]
[8C1h 2241 001h]                      Length : 28

[8C2h 2242 004h]            Proximity Domain : 00000000
[8C6h 2246 002h]                   Reserved1 : 0000
[8C8h 2248 008h]                Base Address : 0000000000000000
[8D0h 2256 008h]              Address Length : 0000000000000000
[8D8h 2264 004h]                   Reserved2 : 00000000
[8DCh 2268 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[8E0h 2272 008h]                   Reserved3 : 0000000000000000

[8E8h 2280 001h]               Subtable Type : 01 [Memory Affinity]
[8E9h 2281 001h]                      Length : 28

[8EAh 2282 004h]            Proximity Domain : 00000000
[8EEh 2286 002h]                   Reserved1 : 0000
[8F0h 2288 008h]                Base Address : 0000000000000000
[8F8h 2296 008h]              Address Length : 0000000000000000
[900h 2304 004h]                   Reserved2 : 00000000
[904h 2308 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[908h 2312 008h]                   Reserved3 : 0000000000000000

[910h 2320 001h]               Subtable Type : 01 [Memory Affinity]
[911h 2321 001h]                      Length : 28

[912h 2322 004h]            Proximity Domain : 00000000
[916h 2326 002h]                   Reserved1 : 0000
[918h 2328 008h]                Base Address : 0000000000000000
[920h 2336 008h]              Address Length : 0000000000000000
[928h 2344 004h]                   Reserved2 : 00000000
[92Ch 2348 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[930h 2352 008h]                   Reserved3 : 0000000000000000

[938h 2360 001h]               Subtable Type : 01 [Memory Affinity]
[939h 2361 001h]                      Length : 28

[93Ah 2362 004h]            Proximity Domain : 00000000
[93Eh 2366 002h]                   Reserved1 : 0000
[940h 2368 008h]                Base Address : 0000000000000000
[948h 2376 008h]              Address Length : 0000000000000000
[950h 2384 004h]                   Reserved2 : 00000000
[954h 2388 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[958h 2392 008h]                   Reserved3 : 0000000000000000

[960h 2400 001h]               Subtable Type : 01 [Memory Affinity]
[961h 2401 001h]                      Length : 28

[962h 2402 004h]            Proximity Domain : 00000000
[966h 2406 002h]                   Reserved1 : 0000
[968h 2408 008h]                Base Address : 0000000000000000
[970h 2416 008h]              Address Length : 0000000000000000
[978h 2424 004h]                   Reserved2 : 00000000
[97Ch 2428 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[980h 2432 008h]                   Reserved3 : 0000000000000000

[988h 2440 001h]               Subtable Type : 01 [Memory Affinity]
[989h 2441 001h]                      Length : 28

[98Ah 2442 004h]            Proximity Domain : 00000000
[98Eh 2446 002h]                   Reserved1 : 0000
[990h 2448 008h]                Base Address : 0000000000000000
[998h 2456 008h]              Address Length : 0000000000000000
[9A0h 2464 004h]                   Reserved2 : 00000000
[9A4h 2468 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[9A8h 2472 008h]                   Reserved3 : 0000000000000000

[9B0h 2480 001h]               Subtable Type : 01 [Memory Affinity]
[9B1h 2481 001h]                      Length : 28

[9B2h 2482 004h]            Proximity Domain : 00000000
[9B6h 2486 002h]                   Reserved1 : 0000
[9B8h 2488 008h]                Base Address : 0000000000000000
[9C0h 2496 008h]              Address Length : 0000000000000000
[9C8h 2504 004h]                   Reserved2 : 00000000
[9CCh 2508 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[9D0h 2512 008h]                   Reserved3 : 0000000000000000

[9D8h 2520 001h]               Subtable Type : 01 [Memory Affinity]
[9D9h 2521 001h]                      Length : 28

[9DAh 2522 004h]            Proximity Domain : 00000000
[9DEh 2526 002h]                   Reserved1 : 0000
[9E0h 2528 008h]                Base Address : 0000000000000000
[9E8h 2536 008h]              Address Length : 0000000000000000
[9F0h 2544 004h]                   Reserved2 : 00000000
[9F4h 2548 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[9F8h 2552 008h]                   Reserved3 : 0000000000000000

[A00h 2560 001h]               Subtable Type : 01 [Memory Affinity]
[A01h 2561 001h]                      Length : 28

[A02h 2562 004h]            Proximity Domain : 00000000
[A06h 2566 002h]                   Reserved1 : 0000
[A08h 2568 008h]                Base Address : 0000000000000000
[A10h 2576 008h]              Address Length : 0000000000000000
[A18h 2584 004h]                   Reserved2 : 00000000
[A1Ch 2588 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[A20h 2592 008h]                   Reserved3 : 0000000000000000

[A28h 2600 001h]               Subtable Type : 01 [Memory Affinity]
[A29h 2601 001h]                      Length : 28

[A2Ah 2602 004h]            Proximity Domain : 00000000
[A2Eh 2606 002h]                   Reserved1 : 0000
[A30h 2608 008h]                Base Address : 0000000000000000
[A38h 2616 008h]              Address Length : 0000000000000000
[A40h 2624 004h]                   Reserved2 : 00000000
[A44h 2628 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[A48h 2632 008h]                   Reserved3 : 0000000000000000

[A50h 2640 001h]               Subtable Type : 01 [Memory Affinity]
[A51h 2641 001h]                      Length : 28

[A52h 2642 004h]            Proximity Domain : 00000000
[A56h 2646 002h]                   Reserved1 : 0000
[A58h 2648 008h]                Base Address : 0000000000000000
[A60h 2656 008h]              Address Length : 0000000000000000
[A68h 2664 004h]                   Reserved2 : 00000000
[A6Ch 2668 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[A70h 2672 008h]                   Reserved3 : 0000000000000000

[A78h 2680 001h]               Subtable Type : 01 [Memory Affinity]
[A79h 2681 001h]                      Length : 28

[A7Ah 2682 004h]            Proximity Domain : 00000000
[A7Eh 2686 002h]                   Reserved1 : 0000
[A80h 2688 008h]                Base Address : 0000000000000000
[A88h 2696 008h]              Address Length : 0000000000000000
[A90h 2704 004h]                   Reserved2 : 00000000
[A94h 2708 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[A98h 2712 008h]                   Reserved3 : 0000000000000000

[AA0h 2720 001h]               Subtable Type : 01 [Memory Affinity]
[AA1h 2721 001h]                      Length : 28

[AA2h 2722 004h]            Proximity Domain : 00000000
[AA6h 2726 002h]                   Reserved1 : 0000
[AA8h 2728 008h]                Base Address : 0000000000000000
[AB0h 2736 008h]              Address Length : 0000000000000000
[AB8h 2744 004h]                   Reserved2 : 00000000
[ABCh 2748 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[AC0h 2752 008h]                   Reserved3 : 0000000000000000

[AC8h 2760 001h]               Subtable Type : 01 [Memory Affinity]
[AC9h 2761 001h]                      Length : 28

[ACAh 2762 004h]            Proximity Domain : 00000000
[ACEh 2766 002h]                   Reserved1 : 0000
[AD0h 2768 008h]                Base Address : 0000000000000000
[AD8h 2776 008h]              Address Length : 0000000000000000
[AE0h 2784 004h]                   Reserved2 : 00000000
[AE4h 2788 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[AE8h 2792 008h]                   Reserved3 : 0000000000000000

[AF0h 2800 001h]               Subtable Type : 01 [Memory Affinity]
[AF1h 2801 001h]                      Length : 28

[AF2h 2802 004h]            Proximity Domain : 00000000
[AF6h 2806 002h]                   Reserved1 : 0000
[AF8h 2808 008h]                Base Address : 0000000000000000
[B00h 2816 008h]              Address Length : 0000000000000000
[B08h 2824 004h]                   Reserved2 : 00000000
[B0Ch 2828 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[B10h 2832 008h]                   Reserved3 : 0000000000000000

[B18h 2840 001h]               Subtable Type : 01 [Memory Affinity]
[B19h 2841 001h]                      Length : 28

[B1Ah 2842 004h]            Proximity Domain : 00000000
[B1Eh 2846 002h]                   Reserved1 : 0000
[B20h 2848 008h]                Base Address : 0000000000000000
[B28h 2856 008h]              Address Length : 0000000000000000
[B30h 2864 004h]                   Reserved2 : 00000000
[B34h 2868 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[B38h 2872 008h]                   Reserved3 : 0000000000000000

[B40h 2880 001h]               Subtable Type : 01 [Memory Affinity]
[B41h 2881 001h]                      Length : 28

[B42h 2882 004h]            Proximity Domain : 00000000
[B46h 2886 002h]                   Reserved1 : 0000
[B48h 2888 008h]                Base Address : 0000000000000000
[B50h 2896 008h]              Address Length : 0000000000000000
[B58h 2904 004h]                   Reserved2 : 00000000
[B5Ch 2908 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[B60h 2912 008h]                   Reserved3 : 0000000000000000

[B68h 2920 001h]               Subtable Type : 01 [Memory Affinity]
[B69h 2921 001h]                      Length : 28

[B6Ah 2922 004h]            Proximity Domain : 00000000
[B6Eh 2926 002h]                   Reserved1 : 0000
[B70h 2928 008h]                Base Address : 0000000000000000
[B78h 2936 008h]              Address Length : 0000000000000000
[B80h 2944 004h]                   Reserved2 : 00000000
[B84h 2948 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[B88h 2952 008h]                   Reserved3 : 0000000000000000

[B90h 2960 001h]               Subtable Type : 01 [Memory Affinity]
[B91h 2961 001h]                      Length : 28

[B92h 2962 004h]            Proximity Domain : 00000000
[B96h 2966 002h]                   Reserved1 : 0000
[B98h 2968 008h]                Base Address : 0000000000000000
[BA0h 2976 008h]              Address Length : 0000000000000000
[BA8h 2984 004h]                   Reserved2 : 00000000
[BACh 2988 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[BB0h 2992 008h]                   Reserved3 : 0000000000000000

[BB8h 3000 001h]               Subtable Type : 01 [Memory Affinity]
[BB9h 3001 001h]                      Length : 28

[BBAh 3002 004h]            Proximity Domain : 00000000
[BBEh 3006 002h]                   Reserved1 : 0000
[BC0h 3008 008h]                Base Address : 0000000000000000
[BC8h 3016 008h]              Address Length : 0000000000000000
[BD0h 3024 004h]                   Reserved2 : 00000000
[BD4h 3028 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[BD8h 3032 008h]                   Reserved3 : 0000000000000000

[BE0h 3040 001h]               Subtable Type : 01 [Memory Affinity]
[BE1h 3041 001h]                      Length : 28

[BE2h 3042 004h]            Proximity Domain : 00000000
[BE6h 3046 002h]                   Reserved1 : 0000
[BE8h 3048 008h]                Base Address : 0000000000000000
[BF0h 3056 008h]              Address Length : 0000000000000000
[BF8h 3064 004h]                   Reserved2 : 00000000
[BFCh 3068 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[C00h 3072 008h]                   Reserved3 : 0000000000000000

[C08h 3080 001h]               Subtable Type : 01 [Memory Affinity]
[C09h 3081 001h]                      Length : 28

[C0Ah 3082 004h]            Proximity Domain : 00000000
[C0Eh 3086 002h]                   Reserved1 : 0000
[C10h 3088 008h]                Base Address : 0000000000000000
[C18h 3096 008h]              Address Length : 0000000000000000
[C20h 3104 004h]                   Reserved2 : 00000000
[C24h 3108 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
                               Hot Pluggable : 0
                                Non-Volatile : 0
[C28h 3112 008h]                   Reserved3 : 0000000000000000

[C30h 3120 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[C31h 3121 001h]                      Length : 18

[C32h 3122 002h]                   Reserved1 : 0000
[C34h 3124 004h]            Proximity Domain : 00000000
[C38h 3128 004h]                     Apic ID : FFFFFFFF
[C3Ch 3132 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[C40h 3136 004h]                Clock Domain : 00000000
[C44h 3140 004h]                   Reserved2 : 00000000

[C48h 3144 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[C49h 3145 001h]                      Length : 18

[C4Ah 3146 002h]                   Reserved1 : 0000
[C4Ch 3148 004h]            Proximity Domain : 00000000
[C50h 3152 004h]                     Apic ID : FFFFFFFF
[C54h 3156 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[C58h 3160 004h]                Clock Domain : 00000000
[C5Ch 3164 004h]                   Reserved2 : 00000000

[C60h 3168 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[C61h 3169 001h]                      Length : 18

[C62h 3170 002h]                   Reserved1 : 0000
[C64h 3172 004h]            Proximity Domain : 00000000
[C68h 3176 004h]                     Apic ID : FFFFFFFF
[C6Ch 3180 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[C70h 3184 004h]                Clock Domain : 00000000
[C74h 3188 004h]                   Reserved2 : 00000000

[C78h 3192 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[C79h 3193 001h]                      Length : 18

[C7Ah 3194 002h]                   Reserved1 : 0000
[C7Ch 3196 004h]            Proximity Domain : 00000000
[C80h 3200 004h]                     Apic ID : FFFFFFFF
[C84h 3204 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[C88h 3208 004h]                Clock Domain : 00000000
[C8Ch 3212 004h]                   Reserved2 : 00000000

[C90h 3216 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[C91h 3217 001h]                      Length : 18

[C92h 3218 002h]                   Reserved1 : 0000
[C94h 3220 004h]            Proximity Domain : 00000000
[C98h 3224 004h]                     Apic ID : FFFFFFFF
[C9Ch 3228 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[CA0h 3232 004h]                Clock Domain : 00000000
[CA4h 3236 004h]                   Reserved2 : 00000000

[CA8h 3240 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[CA9h 3241 001h]                      Length : 18

[CAAh 3242 002h]                   Reserved1 : 0000
[CACh 3244 004h]            Proximity Domain : 00000000
[CB0h 3248 004h]                     Apic ID : FFFFFFFF
[CB4h 3252 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[CB8h 3256 004h]                Clock Domain : 00000000
[CBCh 3260 004h]                   Reserved2 : 00000000

[CC0h 3264 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[CC1h 3265 001h]                      Length : 18

[CC2h 3266 002h]                   Reserved1 : 0000
[CC4h 3268 004h]            Proximity Domain : 00000000
[CC8h 3272 004h]                     Apic ID : FFFFFFFF
[CCCh 3276 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[CD0h 3280 004h]                Clock Domain : 00000000
[CD4h 3284 004h]                   Reserved2 : 00000000

[CD8h 3288 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[CD9h 3289 001h]                      Length : 18

[CDAh 3290 002h]                   Reserved1 : 0000
[CDCh 3292 004h]            Proximity Domain : 00000000
[CE0h 3296 004h]                     Apic ID : FFFFFFFF
[CE4h 3300 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[CE8h 3304 004h]                Clock Domain : 00000000
[CECh 3308 004h]                   Reserved2 : 00000000

[CF0h 3312 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[CF1h 3313 001h]                      Length : 18

[CF2h 3314 002h]                   Reserved1 : 0000
[CF4h 3316 004h]            Proximity Domain : 00000000
[CF8h 3320 004h]                     Apic ID : FFFFFFFF
[CFCh 3324 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[D00h 3328 004h]                Clock Domain : 00000000
[D04h 3332 004h]                   Reserved2 : 00000000

[D08h 3336 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[D09h 3337 001h]                      Length : 18

[D0Ah 3338 002h]                   Reserved1 : 0000
[D0Ch 3340 004h]            Proximity Domain : 00000000
[D10h 3344 004h]                     Apic ID : FFFFFFFF
[D14h 3348 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[D18h 3352 004h]                Clock Domain : 00000000
[D1Ch 3356 004h]                   Reserved2 : 00000000

[D20h 3360 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[D21h 3361 001h]                      Length : 18

[D22h 3362 002h]                   Reserved1 : 0000
[D24h 3364 004h]            Proximity Domain : 00000000
[D28h 3368 004h]                     Apic ID : FFFFFFFF
[D2Ch 3372 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[D30h 3376 004h]                Clock Domain : 00000000
[D34h 3380 004h]                   Reserved2 : 00000000

[D38h 3384 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[D39h 3385 001h]                      Length : 18

[D3Ah 3386 002h]                   Reserved1 : 0000
[D3Ch 3388 004h]            Proximity Domain : 00000000
[D40h 3392 004h]                     Apic ID : FFFFFFFF
[D44h 3396 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[D48h 3400 004h]                Clock Domain : 00000000
[D4Ch 3404 004h]                   Reserved2 : 00000000

[D50h 3408 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[D51h 3409 001h]                      Length : 18

[D52h 3410 002h]                   Reserved1 : 0000
[D54h 3412 004h]            Proximity Domain : 00000000
[D58h 3416 004h]                     Apic ID : FFFFFFFF
[D5Ch 3420 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[D60h 3424 004h]                Clock Domain : 00000000
[D64h 3428 004h]                   Reserved2 : 00000000

[D68h 3432 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[D69h 3433 001h]                      Length : 18

[D6Ah 3434 002h]                   Reserved1 : 0000
[D6Ch 3436 004h]            Proximity Domain : 00000000
[D70h 3440 004h]                     Apic ID : FFFFFFFF
[D74h 3444 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[D78h 3448 004h]                Clock Domain : 00000000
[D7Ch 3452 004h]                   Reserved2 : 00000000

[D80h 3456 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[D81h 3457 001h]                      Length : 18

[D82h 3458 002h]                   Reserved1 : 0000
[D84h 3460 004h]            Proximity Domain : 00000000
[D88h 3464 004h]                     Apic ID : FFFFFFFF
[D8Ch 3468 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[D90h 3472 004h]                Clock Domain : 00000000
[D94h 3476 004h]                   Reserved2 : 00000000

[D98h 3480 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[D99h 3481 001h]                      Length : 18

[D9Ah 3482 002h]                   Reserved1 : 0000
[D9Ch 3484 004h]            Proximity Domain : 00000000
[DA0h 3488 004h]                     Apic ID : FFFFFFFF
[DA4h 3492 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[DA8h 3496 004h]                Clock Domain : 00000000
[DACh 3500 004h]                   Reserved2 : 00000000

[DB0h 3504 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[DB1h 3505 001h]                      Length : 18

[DB2h 3506 002h]                   Reserved1 : 0000
[DB4h 3508 004h]            Proximity Domain : 00000000
[DB8h 3512 004h]                     Apic ID : FFFFFFFF
[DBCh 3516 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[DC0h 3520 004h]                Clock Domain : 00000000
[DC4h 3524 004h]                   Reserved2 : 00000000

[DC8h 3528 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[DC9h 3529 001h]                      Length : 18

[DCAh 3530 002h]                   Reserved1 : 0000
[DCCh 3532 004h]            Proximity Domain : 00000000
[DD0h 3536 004h]                     Apic ID : FFFFFFFF
[DD4h 3540 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[DD8h 3544 004h]                Clock Domain : 00000000
[DDCh 3548 004h]                   Reserved2 : 00000000

[DE0h 3552 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[DE1h 3553 001h]                      Length : 18

[DE2h 3554 002h]                   Reserved1 : 0000
[DE4h 3556 004h]            Proximity Domain : 00000000
[DE8h 3560 004h]                     Apic ID : FFFFFFFF
[DECh 3564 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[DF0h 3568 004h]                Clock Domain : 00000000
[DF4h 3572 004h]                   Reserved2 : 00000000

[DF8h 3576 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[DF9h 3577 001h]                      Length : 18

[DFAh 3578 002h]                   Reserved1 : 0000
[DFCh 3580 004h]            Proximity Domain : 00000000
[E00h 3584 004h]                     Apic ID : FFFFFFFF
[E04h 3588 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[E08h 3592 004h]                Clock Domain : 00000000
[E0Ch 3596 004h]                   Reserved2 : 00000000

[E10h 3600 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[E11h 3601 001h]                      Length : 18

[E12h 3602 002h]                   Reserved1 : 0000
[E14h 3604 004h]            Proximity Domain : 00000000
[E18h 3608 004h]                     Apic ID : FFFFFFFF
[E1Ch 3612 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[E20h 3616 004h]                Clock Domain : 00000000
[E24h 3620 004h]                   Reserved2 : 00000000

[E28h 3624 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[E29h 3625 001h]                      Length : 18

[E2Ah 3626 002h]                   Reserved1 : 0000
[E2Ch 3628 004h]            Proximity Domain : 00000000
[E30h 3632 004h]                     Apic ID : FFFFFFFF
[E34h 3636 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[E38h 3640 004h]                Clock Domain : 00000000
[E3Ch 3644 004h]                   Reserved2 : 00000000

[E40h 3648 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[E41h 3649 001h]                      Length : 18

[E42h 3650 002h]                   Reserved1 : 0000
[E44h 3652 004h]            Proximity Domain : 00000000
[E48h 3656 004h]                     Apic ID : FFFFFFFF
[E4Ch 3660 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[E50h 3664 004h]                Clock Domain : 00000000
[E54h 3668 004h]                   Reserved2 : 00000000

[E58h 3672 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[E59h 3673 001h]                      Length : 18

[E5Ah 3674 002h]                   Reserved1 : 0000
[E5Ch 3676 004h]            Proximity Domain : 00000000
[E60h 3680 004h]                     Apic ID : FFFFFFFF
[E64h 3684 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[E68h 3688 004h]                Clock Domain : 00000000
[E6Ch 3692 004h]                   Reserved2 : 00000000

[E70h 3696 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[E71h 3697 001h]                      Length : 18

[E72h 3698 002h]                   Reserved1 : 0000
[E74h 3700 004h]            Proximity Domain : 00000000
[E78h 3704 004h]                     Apic ID : FFFFFFFF
[E7Ch 3708 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[E80h 3712 004h]                Clock Domain : 00000000
[E84h 3716 004h]                   Reserved2 : 00000000

[E88h 3720 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[E89h 3721 001h]                      Length : 18

[E8Ah 3722 002h]                   Reserved1 : 0000
[E8Ch 3724 004h]            Proximity Domain : 00000000
[E90h 3728 004h]                     Apic ID : FFFFFFFF
[E94h 3732 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[E98h 3736 004h]                Clock Domain : 00000000
[E9Ch 3740 004h]                   Reserved2 : 00000000

[EA0h 3744 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[EA1h 3745 001h]                      Length : 18

[EA2h 3746 002h]                   Reserved1 : 0000
[EA4h 3748 004h]            Proximity Domain : 00000000
[EA8h 3752 004h]                     Apic ID : FFFFFFFF
[EACh 3756 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[EB0h 3760 004h]                Clock Domain : 00000000
[EB4h 3764 004h]                   Reserved2 : 00000000

[EB8h 3768 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[EB9h 3769 001h]                      Length : 18

[EBAh 3770 002h]                   Reserved1 : 0000
[EBCh 3772 004h]            Proximity Domain : 00000000
[EC0h 3776 004h]                     Apic ID : FFFFFFFF
[EC4h 3780 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[EC8h 3784 004h]                Clock Domain : 00000000
[ECCh 3788 004h]                   Reserved2 : 00000000

[ED0h 3792 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[ED1h 3793 001h]                      Length : 18

[ED2h 3794 002h]                   Reserved1 : 0000
[ED4h 3796 004h]            Proximity Domain : 00000000
[ED8h 3800 004h]                     Apic ID : FFFFFFFF
[EDCh 3804 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[EE0h 3808 004h]                Clock Domain : 00000000
[EE4h 3812 004h]                   Reserved2 : 00000000

[EE8h 3816 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[EE9h 3817 001h]                      Length : 18

[EEAh 3818 002h]                   Reserved1 : 0000
[EECh 3820 004h]            Proximity Domain : 00000000
[EF0h 3824 004h]                     Apic ID : FFFFFFFF
[EF4h 3828 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[EF8h 3832 004h]                Clock Domain : 00000000
[EFCh 3836 004h]                   Reserved2 : 00000000

[F00h 3840 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[F01h 3841 001h]                      Length : 18

[F02h 3842 002h]                   Reserved1 : 0000
[F04h 3844 004h]            Proximity Domain : 00000000
[F08h 3848 004h]                     Apic ID : FFFFFFFF
[F0Ch 3852 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[F10h 3856 004h]                Clock Domain : 00000000
[F14h 3860 004h]                   Reserved2 : 00000000

[F18h 3864 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[F19h 3865 001h]                      Length : 18

[F1Ah 3866 002h]                   Reserved1 : 0000
[F1Ch 3868 004h]            Proximity Domain : 00000000
[F20h 3872 004h]                     Apic ID : FFFFFFFF
[F24h 3876 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[F28h 3880 004h]                Clock Domain : 00000000
[F2Ch 3884 004h]                   Reserved2 : 00000000

[F30h 3888 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[F31h 3889 001h]                      Length : 18

[F32h 3890 002h]                   Reserved1 : 0000
[F34h 3892 004h]            Proximity Domain : 00000000
[F38h 3896 004h]                     Apic ID : FFFFFFFF
[F3Ch 3900 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[F40h 3904 004h]                Clock Domain : 00000000
[F44h 3908 004h]                   Reserved2 : 00000000

[F48h 3912 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[F49h 3913 001h]                      Length : 18

[F4Ah 3914 002h]                   Reserved1 : 0000
[F4Ch 3916 004h]            Proximity Domain : 00000000
[F50h 3920 004h]                     Apic ID : FFFFFFFF
[F54h 3924 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[F58h 3928 004h]                Clock Domain : 00000000
[F5Ch 3932 004h]                   Reserved2 : 00000000

[F60h 3936 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[F61h 3937 001h]                      Length : 18

[F62h 3938 002h]                   Reserved1 : 0000
[F64h 3940 004h]            Proximity Domain : 00000000
[F68h 3944 004h]                     Apic ID : FFFFFFFF
[F6Ch 3948 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[F70h 3952 004h]                Clock Domain : 00000000
[F74h 3956 004h]                   Reserved2 : 00000000

[F78h 3960 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[F79h 3961 001h]                      Length : 18

[F7Ah 3962 002h]                   Reserved1 : 0000
[F7Ch 3964 004h]            Proximity Domain : 00000000
[F80h 3968 004h]                     Apic ID : FFFFFFFF
[F84h 3972 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[F88h 3976 004h]                Clock Domain : 00000000
[F8Ch 3980 004h]                   Reserved2 : 00000000

[F90h 3984 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[F91h 3985 001h]                      Length : 18

[F92h 3986 002h]                   Reserved1 : 0000
[F94h 3988 004h]            Proximity Domain : 00000000
[F98h 3992 004h]                     Apic ID : FFFFFFFF
[F9Ch 3996 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[FA0h 4000 004h]                Clock Domain : 00000000
[FA4h 4004 004h]                   Reserved2 : 00000000

[FA8h 4008 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[FA9h 4009 001h]                      Length : 18

[FAAh 4010 002h]                   Reserved1 : 0000
[FACh 4012 004h]            Proximity Domain : 00000000
[FB0h 4016 004h]                     Apic ID : FFFFFFFF
[FB4h 4020 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[FB8h 4024 004h]                Clock Domain : 00000000
[FBCh 4028 004h]                   Reserved2 : 00000000

[FC0h 4032 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[FC1h 4033 001h]                      Length : 18

[FC2h 4034 002h]                   Reserved1 : 0000
[FC4h 4036 004h]            Proximity Domain : 00000000
[FC8h 4040 004h]                     Apic ID : FFFFFFFF
[FCCh 4044 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[FD0h 4048 004h]                Clock Domain : 00000000
[FD4h 4052 004h]                   Reserved2 : 00000000

[FD8h 4056 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[FD9h 4057 001h]                      Length : 18

[FDAh 4058 002h]                   Reserved1 : 0000
[FDCh 4060 004h]            Proximity Domain : 00000000
[FE0h 4064 004h]                     Apic ID : FFFFFFFF
[FE4h 4068 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[FE8h 4072 004h]                Clock Domain : 00000000
[FECh 4076 004h]                   Reserved2 : 00000000

[FF0h 4080 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[FF1h 4081 001h]                      Length : 18

[FF2h 4082 002h]                   Reserved1 : 0000
[FF4h 4084 004h]            Proximity Domain : 00000000
[FF8h 4088 004h]                     Apic ID : FFFFFFFF
[FFCh 4092 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1000h 4096 004h]                Clock Domain : 00000000
[1004h 4100 004h]                   Reserved2 : 00000000

[1008h 4104 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1009h 4105 001h]                      Length : 18

[100Ah 4106 002h]                   Reserved1 : 0000
[100Ch 4108 004h]            Proximity Domain : 00000000
[1010h 4112 004h]                     Apic ID : FFFFFFFF
[1014h 4116 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1018h 4120 004h]                Clock Domain : 00000000
[101Ch 4124 004h]                   Reserved2 : 00000000

[1020h 4128 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1021h 4129 001h]                      Length : 18

[1022h 4130 002h]                   Reserved1 : 0000
[1024h 4132 004h]            Proximity Domain : 00000000
[1028h 4136 004h]                     Apic ID : FFFFFFFF
[102Ch 4140 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1030h 4144 004h]                Clock Domain : 00000000
[1034h 4148 004h]                   Reserved2 : 00000000

[1038h 4152 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1039h 4153 001h]                      Length : 18

[103Ah 4154 002h]                   Reserved1 : 0000
[103Ch 4156 004h]            Proximity Domain : 00000000
[1040h 4160 004h]                     Apic ID : FFFFFFFF
[1044h 4164 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1048h 4168 004h]                Clock Domain : 00000000
[104Ch 4172 004h]                   Reserved2 : 00000000

[1050h 4176 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1051h 4177 001h]                      Length : 18

[1052h 4178 002h]                   Reserved1 : 0000
[1054h 4180 004h]            Proximity Domain : 00000000
[1058h 4184 004h]                     Apic ID : FFFFFFFF
[105Ch 4188 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1060h 4192 004h]                Clock Domain : 00000000
[1064h 4196 004h]                   Reserved2 : 00000000

[1068h 4200 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1069h 4201 001h]                      Length : 18

[106Ah 4202 002h]                   Reserved1 : 0000
[106Ch 4204 004h]            Proximity Domain : 00000000
[1070h 4208 004h]                     Apic ID : FFFFFFFF
[1074h 4212 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1078h 4216 004h]                Clock Domain : 00000000
[107Ch 4220 004h]                   Reserved2 : 00000000

[1080h 4224 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1081h 4225 001h]                      Length : 18

[1082h 4226 002h]                   Reserved1 : 0000
[1084h 4228 004h]            Proximity Domain : 00000000
[1088h 4232 004h]                     Apic ID : FFFFFFFF
[108Ch 4236 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1090h 4240 004h]                Clock Domain : 00000000
[1094h 4244 004h]                   Reserved2 : 00000000

[1098h 4248 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1099h 4249 001h]                      Length : 18

[109Ah 4250 002h]                   Reserved1 : 0000
[109Ch 4252 004h]            Proximity Domain : 00000000
[10A0h 4256 004h]                     Apic ID : FFFFFFFF
[10A4h 4260 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[10A8h 4264 004h]                Clock Domain : 00000000
[10ACh 4268 004h]                   Reserved2 : 00000000

[10B0h 4272 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[10B1h 4273 001h]                      Length : 18

[10B2h 4274 002h]                   Reserved1 : 0000
[10B4h 4276 004h]            Proximity Domain : 00000000
[10B8h 4280 004h]                     Apic ID : FFFFFFFF
[10BCh 4284 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[10C0h 4288 004h]                Clock Domain : 00000000
[10C4h 4292 004h]                   Reserved2 : 00000000

[10C8h 4296 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[10C9h 4297 001h]                      Length : 18

[10CAh 4298 002h]                   Reserved1 : 0000
[10CCh 4300 004h]            Proximity Domain : 00000000
[10D0h 4304 004h]                     Apic ID : FFFFFFFF
[10D4h 4308 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[10D8h 4312 004h]                Clock Domain : 00000000
[10DCh 4316 004h]                   Reserved2 : 00000000

[10E0h 4320 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[10E1h 4321 001h]                      Length : 18

[10E2h 4322 002h]                   Reserved1 : 0000
[10E4h 4324 004h]            Proximity Domain : 00000000
[10E8h 4328 004h]                     Apic ID : FFFFFFFF
[10ECh 4332 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[10F0h 4336 004h]                Clock Domain : 00000000
[10F4h 4340 004h]                   Reserved2 : 00000000

[10F8h 4344 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[10F9h 4345 001h]                      Length : 18

[10FAh 4346 002h]                   Reserved1 : 0000
[10FCh 4348 004h]            Proximity Domain : 00000000
[1100h 4352 004h]                     Apic ID : FFFFFFFF
[1104h 4356 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1108h 4360 004h]                Clock Domain : 00000000
[110Ch 4364 004h]                   Reserved2 : 00000000

[1110h 4368 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1111h 4369 001h]                      Length : 18

[1112h 4370 002h]                   Reserved1 : 0000
[1114h 4372 004h]            Proximity Domain : 00000000
[1118h 4376 004h]                     Apic ID : FFFFFFFF
[111Ch 4380 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1120h 4384 004h]                Clock Domain : 00000000
[1124h 4388 004h]                   Reserved2 : 00000000

[1128h 4392 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1129h 4393 001h]                      Length : 18

[112Ah 4394 002h]                   Reserved1 : 0000
[112Ch 4396 004h]            Proximity Domain : 00000000
[1130h 4400 004h]                     Apic ID : FFFFFFFF
[1134h 4404 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1138h 4408 004h]                Clock Domain : 00000000
[113Ch 4412 004h]                   Reserved2 : 00000000

[1140h 4416 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1141h 4417 001h]                      Length : 18

[1142h 4418 002h]                   Reserved1 : 0000
[1144h 4420 004h]            Proximity Domain : 00000000
[1148h 4424 004h]                     Apic ID : FFFFFFFF
[114Ch 4428 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1150h 4432 004h]                Clock Domain : 00000000
[1154h 4436 004h]                   Reserved2 : 00000000

[1158h 4440 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1159h 4441 001h]                      Length : 18

[115Ah 4442 002h]                   Reserved1 : 0000
[115Ch 4444 004h]            Proximity Domain : 00000000
[1160h 4448 004h]                     Apic ID : FFFFFFFF
[1164h 4452 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1168h 4456 004h]                Clock Domain : 00000000
[116Ch 4460 004h]                   Reserved2 : 00000000

[1170h 4464 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1171h 4465 001h]                      Length : 18

[1172h 4466 002h]                   Reserved1 : 0000
[1174h 4468 004h]            Proximity Domain : 00000000
[1178h 4472 004h]                     Apic ID : FFFFFFFF
[117Ch 4476 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1180h 4480 004h]                Clock Domain : 00000000
[1184h 4484 004h]                   Reserved2 : 00000000

[1188h 4488 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1189h 4489 001h]                      Length : 18

[118Ah 4490 002h]                   Reserved1 : 0000
[118Ch 4492 004h]            Proximity Domain : 00000000
[1190h 4496 004h]                     Apic ID : FFFFFFFF
[1194h 4500 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1198h 4504 004h]                Clock Domain : 00000000
[119Ch 4508 004h]                   Reserved2 : 00000000

[11A0h 4512 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[11A1h 4513 001h]                      Length : 18

[11A2h 4514 002h]                   Reserved1 : 0000
[11A4h 4516 004h]            Proximity Domain : 00000000
[11A8h 4520 004h]                     Apic ID : FFFFFFFF
[11ACh 4524 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[11B0h 4528 004h]                Clock Domain : 00000000
[11B4h 4532 004h]                   Reserved2 : 00000000

[11B8h 4536 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[11B9h 4537 001h]                      Length : 18

[11BAh 4538 002h]                   Reserved1 : 0000
[11BCh 4540 004h]            Proximity Domain : 00000000
[11C0h 4544 004h]                     Apic ID : FFFFFFFF
[11C4h 4548 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[11C8h 4552 004h]                Clock Domain : 00000000
[11CCh 4556 004h]                   Reserved2 : 00000000

[11D0h 4560 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[11D1h 4561 001h]                      Length : 18

[11D2h 4562 002h]                   Reserved1 : 0000
[11D4h 4564 004h]            Proximity Domain : 00000000
[11D8h 4568 004h]                     Apic ID : FFFFFFFF
[11DCh 4572 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[11E0h 4576 004h]                Clock Domain : 00000000
[11E4h 4580 004h]                   Reserved2 : 00000000

[11E8h 4584 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[11E9h 4585 001h]                      Length : 18

[11EAh 4586 002h]                   Reserved1 : 0000
[11ECh 4588 004h]            Proximity Domain : 00000000
[11F0h 4592 004h]                     Apic ID : FFFFFFFF
[11F4h 4596 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[11F8h 4600 004h]                Clock Domain : 00000000
[11FCh 4604 004h]                   Reserved2 : 00000000

[1200h 4608 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1201h 4609 001h]                      Length : 18

[1202h 4610 002h]                   Reserved1 : 0000
[1204h 4612 004h]            Proximity Domain : 00000000
[1208h 4616 004h]                     Apic ID : FFFFFFFF
[120Ch 4620 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1210h 4624 004h]                Clock Domain : 00000000
[1214h 4628 004h]                   Reserved2 : 00000000

[1218h 4632 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1219h 4633 001h]                      Length : 18

[121Ah 4634 002h]                   Reserved1 : 0000
[121Ch 4636 004h]            Proximity Domain : 00000000
[1220h 4640 004h]                     Apic ID : FFFFFFFF
[1224h 4644 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1228h 4648 004h]                Clock Domain : 00000000
[122Ch 4652 004h]                   Reserved2 : 00000000

[1230h 4656 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1231h 4657 001h]                      Length : 18

[1232h 4658 002h]                   Reserved1 : 0000
[1234h 4660 004h]            Proximity Domain : 00000000
[1238h 4664 004h]                     Apic ID : FFFFFFFF
[123Ch 4668 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1240h 4672 004h]                Clock Domain : 00000000
[1244h 4676 004h]                   Reserved2 : 00000000

[1248h 4680 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1249h 4681 001h]                      Length : 18

[124Ah 4682 002h]                   Reserved1 : 0000
[124Ch 4684 004h]            Proximity Domain : 00000000
[1250h 4688 004h]                     Apic ID : FFFFFFFF
[1254h 4692 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1258h 4696 004h]                Clock Domain : 00000000
[125Ch 4700 004h]                   Reserved2 : 00000000

[1260h 4704 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1261h 4705 001h]                      Length : 18

[1262h 4706 002h]                   Reserved1 : 0000
[1264h 4708 004h]            Proximity Domain : 00000000
[1268h 4712 004h]                     Apic ID : FFFFFFFF
[126Ch 4716 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1270h 4720 004h]                Clock Domain : 00000000
[1274h 4724 004h]                   Reserved2 : 00000000

[1278h 4728 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1279h 4729 001h]                      Length : 18

[127Ah 4730 002h]                   Reserved1 : 0000
[127Ch 4732 004h]            Proximity Domain : 00000000
[1280h 4736 004h]                     Apic ID : FFFFFFFF
[1284h 4740 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1288h 4744 004h]                Clock Domain : 00000000
[128Ch 4748 004h]                   Reserved2 : 00000000

[1290h 4752 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1291h 4753 001h]                      Length : 18

[1292h 4754 002h]                   Reserved1 : 0000
[1294h 4756 004h]            Proximity Domain : 00000000
[1298h 4760 004h]                     Apic ID : FFFFFFFF
[129Ch 4764 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[12A0h 4768 004h]                Clock Domain : 00000000
[12A4h 4772 004h]                   Reserved2 : 00000000

[12A8h 4776 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[12A9h 4777 001h]                      Length : 18

[12AAh 4778 002h]                   Reserved1 : 0000
[12ACh 4780 004h]            Proximity Domain : 00000000
[12B0h 4784 004h]                     Apic ID : FFFFFFFF
[12B4h 4788 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[12B8h 4792 004h]                Clock Domain : 00000000
[12BCh 4796 004h]                   Reserved2 : 00000000

[12C0h 4800 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[12C1h 4801 001h]                      Length : 18

[12C2h 4802 002h]                   Reserved1 : 0000
[12C4h 4804 004h]            Proximity Domain : 00000000
[12C8h 4808 004h]                     Apic ID : FFFFFFFF
[12CCh 4812 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[12D0h 4816 004h]                Clock Domain : 00000000
[12D4h 4820 004h]                   Reserved2 : 00000000

[12D8h 4824 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[12D9h 4825 001h]                      Length : 18

[12DAh 4826 002h]                   Reserved1 : 0000
[12DCh 4828 004h]            Proximity Domain : 00000000
[12E0h 4832 004h]                     Apic ID : FFFFFFFF
[12E4h 4836 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[12E8h 4840 004h]                Clock Domain : 00000000
[12ECh 4844 004h]                   Reserved2 : 00000000

[12F0h 4848 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[12F1h 4849 001h]                      Length : 18

[12F2h 4850 002h]                   Reserved1 : 0000
[12F4h 4852 004h]            Proximity Domain : 00000000
[12F8h 4856 004h]                     Apic ID : FFFFFFFF
[12FCh 4860 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1300h 4864 004h]                Clock Domain : 00000000
[1304h 4868 004h]                   Reserved2 : 00000000

[1308h 4872 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1309h 4873 001h]                      Length : 18

[130Ah 4874 002h]                   Reserved1 : 0000
[130Ch 4876 004h]            Proximity Domain : 00000000
[1310h 4880 004h]                     Apic ID : FFFFFFFF
[1314h 4884 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1318h 4888 004h]                Clock Domain : 00000000
[131Ch 4892 004h]                   Reserved2 : 00000000

[1320h 4896 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1321h 4897 001h]                      Length : 18

[1322h 4898 002h]                   Reserved1 : 0000
[1324h 4900 004h]            Proximity Domain : 00000000
[1328h 4904 004h]                     Apic ID : FFFFFFFF
[132Ch 4908 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1330h 4912 004h]                Clock Domain : 00000000
[1334h 4916 004h]                   Reserved2 : 00000000

[1338h 4920 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1339h 4921 001h]                      Length : 18

[133Ah 4922 002h]                   Reserved1 : 0000
[133Ch 4924 004h]            Proximity Domain : 00000000
[1340h 4928 004h]                     Apic ID : FFFFFFFF
[1344h 4932 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1348h 4936 004h]                Clock Domain : 00000000
[134Ch 4940 004h]                   Reserved2 : 00000000

[1350h 4944 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1351h 4945 001h]                      Length : 18

[1352h 4946 002h]                   Reserved1 : 0000
[1354h 4948 004h]            Proximity Domain : 00000000
[1358h 4952 004h]                     Apic ID : FFFFFFFF
[135Ch 4956 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1360h 4960 004h]                Clock Domain : 00000000
[1364h 4964 004h]                   Reserved2 : 00000000

[1368h 4968 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1369h 4969 001h]                      Length : 18

[136Ah 4970 002h]                   Reserved1 : 0000
[136Ch 4972 004h]            Proximity Domain : 00000000
[1370h 4976 004h]                     Apic ID : FFFFFFFF
[1374h 4980 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1378h 4984 004h]                Clock Domain : 00000000
[137Ch 4988 004h]                   Reserved2 : 00000000

[1380h 4992 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1381h 4993 001h]                      Length : 18

[1382h 4994 002h]                   Reserved1 : 0000
[1384h 4996 004h]            Proximity Domain : 00000000
[1388h 5000 004h]                     Apic ID : FFFFFFFF
[138Ch 5004 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1390h 5008 004h]                Clock Domain : 00000000
[1394h 5012 004h]                   Reserved2 : 00000000

[1398h 5016 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1399h 5017 001h]                      Length : 18

[139Ah 5018 002h]                   Reserved1 : 0000
[139Ch 5020 004h]            Proximity Domain : 00000000
[13A0h 5024 004h]                     Apic ID : FFFFFFFF
[13A4h 5028 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[13A8h 5032 004h]                Clock Domain : 00000000
[13ACh 5036 004h]                   Reserved2 : 00000000

[13B0h 5040 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[13B1h 5041 001h]                      Length : 18

[13B2h 5042 002h]                   Reserved1 : 0000
[13B4h 5044 004h]            Proximity Domain : 00000000
[13B8h 5048 004h]                     Apic ID : FFFFFFFF
[13BCh 5052 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[13C0h 5056 004h]                Clock Domain : 00000000
[13C4h 5060 004h]                   Reserved2 : 00000000

[13C8h 5064 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[13C9h 5065 001h]                      Length : 18

[13CAh 5066 002h]                   Reserved1 : 0000
[13CCh 5068 004h]            Proximity Domain : 00000000
[13D0h 5072 004h]                     Apic ID : FFFFFFFF
[13D4h 5076 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[13D8h 5080 004h]                Clock Domain : 00000000
[13DCh 5084 004h]                   Reserved2 : 00000000

[13E0h 5088 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[13E1h 5089 001h]                      Length : 18

[13E2h 5090 002h]                   Reserved1 : 0000
[13E4h 5092 004h]            Proximity Domain : 00000000
[13E8h 5096 004h]                     Apic ID : FFFFFFFF
[13ECh 5100 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[13F0h 5104 004h]                Clock Domain : 00000000
[13F4h 5108 004h]                   Reserved2 : 00000000

[13F8h 5112 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[13F9h 5113 001h]                      Length : 18

[13FAh 5114 002h]                   Reserved1 : 0000
[13FCh 5116 004h]            Proximity Domain : 00000000
[1400h 5120 004h]                     Apic ID : FFFFFFFF
[1404h 5124 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1408h 5128 004h]                Clock Domain : 00000000
[140Ch 5132 004h]                   Reserved2 : 00000000

[1410h 5136 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1411h 5137 001h]                      Length : 18

[1412h 5138 002h]                   Reserved1 : 0000
[1414h 5140 004h]            Proximity Domain : 00000000
[1418h 5144 004h]                     Apic ID : FFFFFFFF
[141Ch 5148 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1420h 5152 004h]                Clock Domain : 00000000
[1424h 5156 004h]                   Reserved2 : 00000000

[1428h 5160 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1429h 5161 001h]                      Length : 18

[142Ah 5162 002h]                   Reserved1 : 0000
[142Ch 5164 004h]            Proximity Domain : 00000000
[1430h 5168 004h]                     Apic ID : FFFFFFFF
[1434h 5172 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1438h 5176 004h]                Clock Domain : 00000000
[143Ch 5180 004h]                   Reserved2 : 00000000

[1440h 5184 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1441h 5185 001h]                      Length : 18

[1442h 5186 002h]                   Reserved1 : 0000
[1444h 5188 004h]            Proximity Domain : 00000000
[1448h 5192 004h]                     Apic ID : FFFFFFFF
[144Ch 5196 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1450h 5200 004h]                Clock Domain : 00000000
[1454h 5204 004h]                   Reserved2 : 00000000

[1458h 5208 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1459h 5209 001h]                      Length : 18

[145Ah 5210 002h]                   Reserved1 : 0000
[145Ch 5212 004h]            Proximity Domain : 00000000
[1460h 5216 004h]                     Apic ID : FFFFFFFF
[1464h 5220 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1468h 5224 004h]                Clock Domain : 00000000
[146Ch 5228 004h]                   Reserved2 : 00000000

[1470h 5232 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1471h 5233 001h]                      Length : 18

[1472h 5234 002h]                   Reserved1 : 0000
[1474h 5236 004h]            Proximity Domain : 00000000
[1478h 5240 004h]                     Apic ID : FFFFFFFF
[147Ch 5244 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1480h 5248 004h]                Clock Domain : 00000000
[1484h 5252 004h]                   Reserved2 : 00000000

[1488h 5256 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1489h 5257 001h]                      Length : 18

[148Ah 5258 002h]                   Reserved1 : 0000
[148Ch 5260 004h]            Proximity Domain : 00000000
[1490h 5264 004h]                     Apic ID : FFFFFFFF
[1494h 5268 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1498h 5272 004h]                Clock Domain : 00000000
[149Ch 5276 004h]                   Reserved2 : 00000000

[14A0h 5280 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[14A1h 5281 001h]                      Length : 18

[14A2h 5282 002h]                   Reserved1 : 0000
[14A4h 5284 004h]            Proximity Domain : 00000000
[14A8h 5288 004h]                     Apic ID : FFFFFFFF
[14ACh 5292 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[14B0h 5296 004h]                Clock Domain : 00000000
[14B4h 5300 004h]                   Reserved2 : 00000000

[14B8h 5304 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[14B9h 5305 001h]                      Length : 18

[14BAh 5306 002h]                   Reserved1 : 0000
[14BCh 5308 004h]            Proximity Domain : 00000000
[14C0h 5312 004h]                     Apic ID : FFFFFFFF
[14C4h 5316 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[14C8h 5320 004h]                Clock Domain : 00000000
[14CCh 5324 004h]                   Reserved2 : 00000000

[14D0h 5328 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[14D1h 5329 001h]                      Length : 18

[14D2h 5330 002h]                   Reserved1 : 0000
[14D4h 5332 004h]            Proximity Domain : 00000000
[14D8h 5336 004h]                     Apic ID : FFFFFFFF
[14DCh 5340 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[14E0h 5344 004h]                Clock Domain : 00000000
[14E4h 5348 004h]                   Reserved2 : 00000000

[14E8h 5352 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[14E9h 5353 001h]                      Length : 18

[14EAh 5354 002h]                   Reserved1 : 0000
[14ECh 5356 004h]            Proximity Domain : 00000000
[14F0h 5360 004h]                     Apic ID : FFFFFFFF
[14F4h 5364 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[14F8h 5368 004h]                Clock Domain : 00000000
[14FCh 5372 004h]                   Reserved2 : 00000000

[1500h 5376 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1501h 5377 001h]                      Length : 18

[1502h 5378 002h]                   Reserved1 : 0000
[1504h 5380 004h]            Proximity Domain : 00000000
[1508h 5384 004h]                     Apic ID : FFFFFFFF
[150Ch 5388 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1510h 5392 004h]                Clock Domain : 00000000
[1514h 5396 004h]                   Reserved2 : 00000000

[1518h 5400 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1519h 5401 001h]                      Length : 18

[151Ah 5402 002h]                   Reserved1 : 0000
[151Ch 5404 004h]            Proximity Domain : 00000000
[1520h 5408 004h]                     Apic ID : FFFFFFFF
[1524h 5412 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1528h 5416 004h]                Clock Domain : 00000000
[152Ch 5420 004h]                   Reserved2 : 00000000

[1530h 5424 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1531h 5425 001h]                      Length : 18

[1532h 5426 002h]                   Reserved1 : 0000
[1534h 5428 004h]            Proximity Domain : 00000000
[1538h 5432 004h]                     Apic ID : FFFFFFFF
[153Ch 5436 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1540h 5440 004h]                Clock Domain : 00000000
[1544h 5444 004h]                   Reserved2 : 00000000

[1548h 5448 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1549h 5449 001h]                      Length : 18

[154Ah 5450 002h]                   Reserved1 : 0000
[154Ch 5452 004h]            Proximity Domain : 00000000
[1550h 5456 004h]                     Apic ID : FFFFFFFF
[1554h 5460 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1558h 5464 004h]                Clock Domain : 00000000
[155Ch 5468 004h]                   Reserved2 : 00000000

[1560h 5472 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1561h 5473 001h]                      Length : 18

[1562h 5474 002h]                   Reserved1 : 0000
[1564h 5476 004h]            Proximity Domain : 00000000
[1568h 5480 004h]                     Apic ID : FFFFFFFF
[156Ch 5484 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1570h 5488 004h]                Clock Domain : 00000000
[1574h 5492 004h]                   Reserved2 : 00000000

[1578h 5496 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1579h 5497 001h]                      Length : 18

[157Ah 5498 002h]                   Reserved1 : 0000
[157Ch 5500 004h]            Proximity Domain : 00000000
[1580h 5504 004h]                     Apic ID : FFFFFFFF
[1584h 5508 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1588h 5512 004h]                Clock Domain : 00000000
[158Ch 5516 004h]                   Reserved2 : 00000000

[1590h 5520 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1591h 5521 001h]                      Length : 18

[1592h 5522 002h]                   Reserved1 : 0000
[1594h 5524 004h]            Proximity Domain : 00000000
[1598h 5528 004h]                     Apic ID : FFFFFFFF
[159Ch 5532 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[15A0h 5536 004h]                Clock Domain : 00000000
[15A4h 5540 004h]                   Reserved2 : 00000000

[15A8h 5544 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[15A9h 5545 001h]                      Length : 18

[15AAh 5546 002h]                   Reserved1 : 0000
[15ACh 5548 004h]            Proximity Domain : 00000000
[15B0h 5552 004h]                     Apic ID : FFFFFFFF
[15B4h 5556 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[15B8h 5560 004h]                Clock Domain : 00000000
[15BCh 5564 004h]                   Reserved2 : 00000000

[15C0h 5568 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[15C1h 5569 001h]                      Length : 18

[15C2h 5570 002h]                   Reserved1 : 0000
[15C4h 5572 004h]            Proximity Domain : 00000000
[15C8h 5576 004h]                     Apic ID : FFFFFFFF
[15CCh 5580 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[15D0h 5584 004h]                Clock Domain : 00000000
[15D4h 5588 004h]                   Reserved2 : 00000000

[15D8h 5592 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[15D9h 5593 001h]                      Length : 18

[15DAh 5594 002h]                   Reserved1 : 0000
[15DCh 5596 004h]            Proximity Domain : 00000000
[15E0h 5600 004h]                     Apic ID : FFFFFFFF
[15E4h 5604 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[15E8h 5608 004h]                Clock Domain : 00000000
[15ECh 5612 004h]                   Reserved2 : 00000000

[15F0h 5616 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[15F1h 5617 001h]                      Length : 18

[15F2h 5618 002h]                   Reserved1 : 0000
[15F4h 5620 004h]            Proximity Domain : 00000000
[15F8h 5624 004h]                     Apic ID : FFFFFFFF
[15FCh 5628 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1600h 5632 004h]                Clock Domain : 00000000
[1604h 5636 004h]                   Reserved2 : 00000000

[1608h 5640 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1609h 5641 001h]                      Length : 18

[160Ah 5642 002h]                   Reserved1 : 0000
[160Ch 5644 004h]            Proximity Domain : 00000000
[1610h 5648 004h]                     Apic ID : FFFFFFFF
[1614h 5652 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1618h 5656 004h]                Clock Domain : 00000000
[161Ch 5660 004h]                   Reserved2 : 00000000

[1620h 5664 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1621h 5665 001h]                      Length : 18

[1622h 5666 002h]                   Reserved1 : 0000
[1624h 5668 004h]            Proximity Domain : 00000000
[1628h 5672 004h]                     Apic ID : FFFFFFFF
[162Ch 5676 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1630h 5680 004h]                Clock Domain : 00000000
[1634h 5684 004h]                   Reserved2 : 00000000

[1638h 5688 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1639h 5689 001h]                      Length : 18

[163Ah 5690 002h]                   Reserved1 : 0000
[163Ch 5692 004h]            Proximity Domain : 00000000
[1640h 5696 004h]                     Apic ID : FFFFFFFF
[1644h 5700 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1648h 5704 004h]                Clock Domain : 00000000
[164Ch 5708 004h]                   Reserved2 : 00000000

[1650h 5712 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1651h 5713 001h]                      Length : 18

[1652h 5714 002h]                   Reserved1 : 0000
[1654h 5716 004h]            Proximity Domain : 00000000
[1658h 5720 004h]                     Apic ID : FFFFFFFF
[165Ch 5724 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1660h 5728 004h]                Clock Domain : 00000000
[1664h 5732 004h]                   Reserved2 : 00000000

[1668h 5736 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1669h 5737 001h]                      Length : 18

[166Ah 5738 002h]                   Reserved1 : 0000
[166Ch 5740 004h]            Proximity Domain : 00000000
[1670h 5744 004h]                     Apic ID : FFFFFFFF
[1674h 5748 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1678h 5752 004h]                Clock Domain : 00000000
[167Ch 5756 004h]                   Reserved2 : 00000000

[1680h 5760 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1681h 5761 001h]                      Length : 18

[1682h 5762 002h]                   Reserved1 : 0000
[1684h 5764 004h]            Proximity Domain : 00000000
[1688h 5768 004h]                     Apic ID : FFFFFFFF
[168Ch 5772 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[1690h 5776 004h]                Clock Domain : 00000000
[1694h 5780 004h]                   Reserved2 : 00000000

[1698h 5784 001h]               Subtable Type : 02 [Processor Local x2APIC Affinity]
[1699h 5785 001h]                      Length : 18

[169Ah 5786 002h]                   Reserved1 : 0000
[169Ch 5788 004h]            Proximity Domain : 00000000
[16A0h 5792 004h]                     Apic ID : FFFFFFFF
[16A4h 5796 004h]       Flags (decoded below) : 00000000
                                     Enabled : 0
[16A8h 5800 004h]                Clock Domain : 00000000
[16ACh 5804 004h]                   Reserved2 : 00000000

Raw Table Data: Length 5808 (0x16B0)

    0000: 53 52 41 54 B0 16 00 00 03 94 41 4C 41 53 4B 41  // SRAT......ALASKA
    0010: 41 20 4D 20 49 20 00 00 02 00 00 00 49 4E 54 4C  // A M I ......INTL
    0020: 13 10 09 20 01 00 00 00 00 00 00 00 00 00 00 00  // ... ............
    0030: 00 10 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0040: 00 10 00 02 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0050: 00 10 00 04 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0060: 00 10 00 06 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0070: 00 10 00 08 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0080: 00 10 00 10 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0090: 00 10 00 12 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    00A0: 00 10 00 14 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    00B0: 00 10 00 16 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    00C0: 00 10 00 18 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    00D0: 00 10 00 20 01 00 00 00 00 00 00 00 00 00 00 00  // ... ............
    00E0: 00 10 00 22 01 00 00 00 00 00 00 00 00 00 00 00  // ..."............
    00F0: 00 10 00 24 01 00 00 00 00 00 00 00 00 00 00 00  // ...$............
    0100: 00 10 00 26 01 00 00 00 00 00 00 00 00 00 00 00  // ...&............
    0110: 00 10 00 28 01 00 00 00 00 00 00 00 00 00 00 00  // ...(............
    0120: 00 10 00 30 01 00 00 00 00 00 00 00 00 00 00 00  // ...0............
    0130: 00 10 00 32 01 00 00 00 00 00 00 00 00 00 00 00  // ...2............
    0140: 00 10 00 34 01 00 00 00 00 00 00 00 00 00 00 00  // ...4............
    0150: 00 10 00 36 01 00 00 00 00 00 00 00 00 00 00 00  // ...6............
    0160: 00 10 00 38 01 00 00 00 00 00 00 00 00 00 00 00  // ...8............
    0170: 00 10 01 40 01 00 00 00 00 00 00 00 00 00 00 00  // ...@............
    0180: 00 10 01 42 01 00 00 00 00 00 00 00 00 00 00 00  // ...B............
    0190: 00 10 01 44 01 00 00 00 00 00 00 00 00 00 00 00  // ...D............
    01A0: 00 10 01 46 01 00 00 00 00 00 00 00 00 00 00 00  // ...F............
    01B0: 00 10 01 48 01 00 00 00 00 00 00 00 00 00 00 00  // ...H............
    01C0: 00 10 01 50 01 00 00 00 00 00 00 00 00 00 00 00  // ...P............
    01D0: 00 10 01 52 01 00 00 00 00 00 00 00 00 00 00 00  // ...R............
    01E0: 00 10 01 54 01 00 00 00 00 00 00 00 00 00 00 00  // ...T............
    01F0: 00 10 01 56 01 00 00 00 00 00 00 00 00 00 00 00  // ...V............
    0200: 00 10 01 58 01 00 00 00 00 00 00 00 00 00 00 00  // ...X............
    0210: 00 10 01 60 01 00 00 00 00 00 00 00 00 00 00 00  // ...`............
    0220: 00 10 01 62 01 00 00 00 00 00 00 00 00 00 00 00  // ...b............
    0230: 00 10 01 64 01 00 00 00 00 00 00 00 00 00 00 00  // ...d............
    0240: 00 10 01 66 01 00 00 00 00 00 00 00 00 00 00 00  // ...f............
    0250: 00 10 01 68 01 00 00 00 00 00 00 00 00 00 00 00  // ...h............
    0260: 00 10 01 70 01 00 00 00 00 00 00 00 00 00 00 00  // ...p............
    0270: 00 10 01 72 01 00 00 00 00 00 00 00 00 00 00 00  // ...r............
    0280: 00 10 01 74 01 00 00 00 00 00 00 00 00 00 00 00  // ...t............
    0290: 00 10 01 76 01 00 00 00 00 00 00 00 00 00 00 00  // ...v............
    02A0: 00 10 01 78 01 00 00 00 00 00 00 00 00 00 00 00  // ...x............
    02B0: 00 10 00 01 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    02C0: 00 10 00 03 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    02D0: 00 10 00 05 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    02E0: 00 10 00 07 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    02F0: 00 10 00 09 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0300: 00 10 00 11 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0310: 00 10 00 13 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0320: 00 10 00 15 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0330: 00 10 00 17 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0340: 00 10 00 19 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0350: 00 10 00 21 01 00 00 00 00 00 00 00 00 00 00 00  // ...!............
    0360: 00 10 00 23 01 00 00 00 00 00 00 00 00 00 00 00  // ...#............
    0370: 00 10 00 25 01 00 00 00 00 00 00 00 00 00 00 00  // ...%............
    0380: 00 10 00 27 01 00 00 00 00 00 00 00 00 00 00 00  // ...'............
    0390: 00 10 00 29 01 00 00 00 00 00 00 00 00 00 00 00  // ...)............
    03A0: 00 10 00 31 01 00 00 00 00 00 00 00 00 00 00 00  // ...1............
    03B0: 00 10 00 33 01 00 00 00 00 00 00 00 00 00 00 00  // ...3............
    03C0: 00 10 00 35 01 00 00 00 00 00 00 00 00 00 00 00  // ...5............
    03D0: 00 10 00 37 01 00 00 00 00 00 00 00 00 00 00 00  // ...7............
    03E0: 00 10 00 39 01 00 00 00 00 00 00 00 00 00 00 00  // ...9............
    03F0: 00 10 01 41 01 00 00 00 00 00 00 00 00 00 00 00  // ...A............
    0400: 00 10 01 43 01 00 00 00 00 00 00 00 00 00 00 00  // ...C............
    0410: 00 10 01 45 01 00 00 00 00 00 00 00 00 00 00 00  // ...E............
    0420: 00 10 01 47 01 00 00 00 00 00 00 00 00 00 00 00  // ...G............
    0430: 00 10 01 49 01 00 00 00 00 00 00 00 00 00 00 00  // ...I............
    0440: 00 10 01 51 01 00 00 00 00 00 00 00 00 00 00 00  // ...Q............
    0450: 00 10 01 53 01 00 00 00 00 00 00 00 00 00 00 00  // ...S............
    0460: 00 10 01 55 01 00 00 00 00 00 00 00 00 00 00 00  // ...U............
    0470: 00 10 01 57 01 00 00 00 00 00 00 00 00 00 00 00  // ...W............
    0480: 00 10 01 59 01 00 00 00 00 00 00 00 00 00 00 00  // ...Y............
    0490: 00 10 01 61 01 00 00 00 00 00 00 00 00 00 00 00  // ...a............
    04A0: 00 10 01 63 01 00 00 00 00 00 00 00 00 00 00 00  // ...c............
    04B0: 00 10 01 65 01 00 00 00 00 00 00 00 00 00 00 00  // ...e............
    04C0: 00 10 01 67 01 00 00 00 00 00 00 00 00 00 00 00  // ...g............
    04D0: 00 10 01 69 01 00 00 00 00 00 00 00 00 00 00 00  // ...i............
    04E0: 00 10 01 71 01 00 00 00 00 00 00 00 00 00 00 00  // ...q............
    04F0: 00 10 01 73 01 00 00 00 00 00 00 00 00 00 00 00  // ...s............
    0500: 00 10 01 75 01 00 00 00 00 00 00 00 00 00 00 00  // ...u............
    0510: 00 10 01 77 01 00 00 00 00 00 00 00 00 00 00 00  // ...w............
    0520: 00 10 01 79 01 00 00 00 00 00 00 00 00 00 00 00  // ...y............
    0530: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0540: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0550: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0560: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0570: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0580: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0590: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    05A0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    05B0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    05C0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    05D0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    05E0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    05F0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0600: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0610: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0620: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0630: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0640: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0650: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0660: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0670: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0680: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0690: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    06A0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    06B0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    06C0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    06D0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    06E0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    06F0: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0700: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0710: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0720: 00 10 00 FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0730: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0740: 00 00 00 80 00 00 00 00 00 00 00 00 01 00 00 00  // ................
    0750: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0760: 00 00 00 00 01 00 00 00 00 00 00 40 0B 00 00 00  // ...........@....
    0770: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0780: 01 28 00 00 00 00 00 00 00 00 00 40 0C 00 00 00  // .(.........@....
    0790: 00 00 00 00 0C 00 00 00 00 00 00 00 01 00 00 00  // ................
    07A0: 00 00 00 00 00 00 00 00 01 28 01 00 00 00 00 00  // .........(......
    07B0: 00 00 00 40 18 00 00 00 00 00 00 00 0C 00 00 00  // ...@............
    07C0: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    07D0: 01 28 01 00 00 00 00 00 00 00 00 40 24 00 00 00  // .(.........@$...
    07E0: 00 00 00 00 0C 00 00 00 00 00 00 00 01 00 00 00  // ................
    07F0: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0820: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0840: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0870: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0890: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    08A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    08B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    08C0: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    08D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    08E0: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    08F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0910: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0920: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0930: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0940: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0950: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0960: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0980: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0990: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    09A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    09B0: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    09C0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    09D0: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    09E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    09F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0A00: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0A10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0A20: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0A30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0A40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0A50: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0A60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0A70: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0A80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0A90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0AA0: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0AB0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0AC0: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0AD0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0AE0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0AF0: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0B00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0B10: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0B20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0B30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0B40: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0B50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0B60: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0B70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0B80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0B90: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0BA0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0BB0: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0BC0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0BD0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0BE0: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0BF0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0C00: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0C10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0C20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0C30: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0C40: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0C50: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0C60: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0C70: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0C80: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0C90: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0CA0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0CB0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0CC0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0CD0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0CE0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0CF0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0D00: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0D10: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0D20: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0D30: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0D40: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0D50: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0D60: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0D70: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0D80: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0D90: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0DA0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0DB0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0DC0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0DD0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0DE0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0DF0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0E00: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0E10: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0E20: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0E30: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0E40: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0E50: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0E60: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0E70: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0E80: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0E90: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0EA0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0EB0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0EC0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0ED0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0EE0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0EF0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0F00: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0F10: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0F20: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0F30: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0F40: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0F50: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0F60: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0F70: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0F80: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0F90: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0FA0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0FB0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0FC0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    0FD0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    0FE0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0FF0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1000: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1010: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1020: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1030: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1040: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1050: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1060: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1070: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1080: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1090: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    10A0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    10B0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    10C0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    10D0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    10E0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    10F0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1100: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1110: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1120: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1130: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1140: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1150: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1160: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1170: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1180: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1190: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    11A0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    11B0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    11C0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    11D0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    11E0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    11F0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1200: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1210: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1220: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1230: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1240: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1250: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1260: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1270: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1280: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1290: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    12A0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    12B0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    12C0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    12D0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    12E0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    12F0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1300: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1310: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1320: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1330: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1340: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1350: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1360: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1370: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1380: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1390: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    13A0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    13B0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    13C0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    13D0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    13E0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    13F0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1400: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1410: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1420: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1430: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1440: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1450: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1460: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1470: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1480: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1490: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    14A0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    14B0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    14C0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    14D0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    14E0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    14F0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1500: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1510: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1520: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1530: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1540: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1550: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1560: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1570: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1580: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1590: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    15A0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    15B0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    15C0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    15D0: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    15E0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    15F0: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1600: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1610: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1620: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1630: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1640: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1650: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1660: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    1670: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    1680: 02 18 00 00 00 00 00 00 FF FF FF FF 00 00 00 00  // ................
    1690: 00 00 00 00 00 00 00 00 02 18 00 00 00 00 00 00  // ................
    16A0: FF FF FF FF 00 00 00 00 00 00 00 00 00 00 00 00  // ................
