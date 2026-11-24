/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20260930 (64-bit version)
 * Copyright (c) 2000 - 2026 Intel Corporation
 * 
 * Disassembly of ../../../ACPI/DMAR.aml
 *
 * ACPI Data Table [DMAR]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "DMAR"    [DMA Remapping Table]
[004h 0004 004h]                Table Length : 00000240
[008h 0008 001h]                    Revision : 01
[009h 0009 001h]                    Checksum : C0
[00Ah 0010 006h]                      Oem ID : "ALASKA"
[010h 0016 008h]                Oem Table ID : "A M I "
[018h 0024 004h]                Oem Revision : 00000001
[01Ch 0028 004h]             Asl Compiler ID : "INTL"
[020h 0032 004h]       Asl Compiler Revision : 20091013

[024h 0036 001h]          Host Address Width : 2D
[025h 0037 001h]                       Flags : 01
[026h 0038 00Ah]                    Reserved : 00 00 00 00 00 00 00 00 00 00

[030h 0048 002h]               Subtable Type : 0000 [Hardware Unit Definition]
[032h 0050 002h]                      Length : 0058

[034h 0052 001h]                       Flags : 00
[035h 0053 001h]        Size (decoded below) : 00
                          Size (pages, log2) : 0
[036h 0054 002h]          PCI Segment Number : 0000
[038h 0056 008h]       Register Base Address : 00000000BD3FC000

[040h 0064 001h]           Device Scope Type : 03 [IOAPIC Device]
[041h 0065 001h]                Entry Length : 08
[042h 0066 001h]                       Flags : 00
[043h 0067 001h]                    Reserved : 00
[044h 0068 001h]              Enumeration ID : 0F
[045h 0069 001h]              PCI Bus Number : 80

[046h 0070 002h]                    PCI Path : 05,04


[048h 0072 001h]           Device Scope Type : 01 [PCI Endpoint Device]
[049h 0073 001h]                Entry Length : 08
[04Ah 0074 001h]                       Flags : 00
[04Bh 0075 001h]                    Reserved : 00
[04Ch 0076 001h]              Enumeration ID : 00
[04Dh 0077 001h]              PCI Bus Number : 80

[04Eh 0078 002h]                    PCI Path : 04,00


[050h 0080 001h]           Device Scope Type : 01 [PCI Endpoint Device]
[051h 0081 001h]                Entry Length : 08
[052h 0082 001h]                       Flags : 00
[053h 0083 001h]                    Reserved : 00
[054h 0084 001h]              Enumeration ID : 00
[055h 0085 001h]              PCI Bus Number : 80

[056h 0086 002h]                    PCI Path : 04,01


[058h 0088 001h]           Device Scope Type : 01 [PCI Endpoint Device]
[059h 0089 001h]                Entry Length : 08
[05Ah 0090 001h]                       Flags : 00
[05Bh 0091 001h]                    Reserved : 00
[05Ch 0092 001h]              Enumeration ID : 00
[05Dh 0093 001h]              PCI Bus Number : 80

[05Eh 0094 002h]                    PCI Path : 04,02


[060h 0096 001h]           Device Scope Type : 01 [PCI Endpoint Device]
[061h 0097 001h]                Entry Length : 08
[062h 0098 001h]                       Flags : 00
[063h 0099 001h]                    Reserved : 00
[064h 0100 001h]              Enumeration ID : 00
[065h 0101 001h]              PCI Bus Number : 80

[066h 0102 002h]                    PCI Path : 04,03


[068h 0104 001h]           Device Scope Type : 01 [PCI Endpoint Device]
[069h 0105 001h]                Entry Length : 08
[06Ah 0106 001h]                       Flags : 00
[06Bh 0107 001h]                    Reserved : 00
[06Ch 0108 001h]              Enumeration ID : 00
[06Dh 0109 001h]              PCI Bus Number : 80

[06Eh 0110 002h]                    PCI Path : 04,04


[070h 0112 001h]           Device Scope Type : 01 [PCI Endpoint Device]
[071h 0113 001h]                Entry Length : 08
[072h 0114 001h]                       Flags : 00
[073h 0115 001h]                    Reserved : 00
[074h 0116 001h]              Enumeration ID : 00
[075h 0117 001h]              PCI Bus Number : 80

[076h 0118 002h]                    PCI Path : 04,05


[078h 0120 001h]           Device Scope Type : 01 [PCI Endpoint Device]
[079h 0121 001h]                Entry Length : 08
[07Ah 0122 001h]                       Flags : 00
[07Bh 0123 001h]                    Reserved : 00
[07Ch 0124 001h]              Enumeration ID : 00
[07Dh 0125 001h]              PCI Bus Number : 80

[07Eh 0126 002h]                    PCI Path : 04,06


[080h 0128 001h]           Device Scope Type : 01 [PCI Endpoint Device]
[081h 0129 001h]                Entry Length : 08
[082h 0130 001h]                       Flags : 00
[083h 0131 001h]                    Reserved : 00
[084h 0132 001h]              Enumeration ID : 00
[085h 0133 001h]              PCI Bus Number : 80

[086h 0134 002h]                    PCI Path : 04,07


[088h 0136 002h]               Subtable Type : 0000 [Hardware Unit Definition]
[08Ah 0138 002h]                      Length : 0018

[08Ch 0140 001h]                       Flags : 00
[08Dh 0141 001h]        Size (decoded below) : 00
                          Size (pages, log2) : 0
[08Eh 0142 002h]          PCI Segment Number : 0000
[090h 0144 008h]       Register Base Address : 00000000BD7FC000

[098h 0152 001h]           Device Scope Type : 03 [IOAPIC Device]
[099h 0153 001h]                Entry Length : 08
[09Ah 0154 001h]                       Flags : 00
[09Bh 0155 001h]                    Reserved : 00
[09Ch 0156 001h]              Enumeration ID : 10
[09Dh 0157 001h]              PCI Bus Number : 85

[09Eh 0158 002h]                    PCI Path : 05,04


[0A0h 0160 002h]               Subtable Type : 0000 [Hardware Unit Definition]
[0A2h 0162 002h]                      Length : 0020

[0A4h 0164 001h]                       Flags : 00
[0A5h 0165 001h]        Size (decoded below) : 00
                          Size (pages, log2) : 0
[0A6h 0166 002h]          PCI Segment Number : 0000
[0A8h 0168 008h]       Register Base Address : 00000000D07FC000

[0B0h 0176 001h]           Device Scope Type : 03 [IOAPIC Device]
[0B1h 0177 001h]                Entry Length : 08
[0B2h 0178 001h]                       Flags : 00
[0B3h 0179 001h]                    Reserved : 00
[0B4h 0180 001h]              Enumeration ID : 11
[0B5h 0181 001h]              PCI Bus Number : AE

[0B6h 0182 002h]                    PCI Path : 05,04


[0B8h 0184 001h]           Device Scope Type : 02 [PCI Bridge Device]
[0B9h 0185 001h]                Entry Length : 08
[0BAh 0186 001h]                       Flags : 00
[0BBh 0187 001h]                    Reserved : 00
[0BCh 0188 001h]              Enumeration ID : 00
[0BDh 0189 001h]              PCI Bus Number : AE

[0BEh 0190 002h]                    PCI Path : 00,00


[0C0h 0192 002h]               Subtable Type : 0000 [Hardware Unit Definition]
[0C2h 0194 002h]                      Length : 0020

[0C4h 0196 001h]                       Flags : 00
[0C5h 0197 001h]        Size (decoded below) : 00
                          Size (pages, log2) : 0
[0C6h 0198 002h]          PCI Segment Number : 0000
[0C8h 0200 008h]       Register Base Address : 00000000FBFFC000

[0D0h 0208 001h]           Device Scope Type : 03 [IOAPIC Device]
[0D1h 0209 001h]                Entry Length : 08
[0D2h 0210 001h]                       Flags : 00
[0D3h 0211 001h]                    Reserved : 00
[0D4h 0212 001h]              Enumeration ID : 12
[0D5h 0213 001h]              PCI Bus Number : D7

[0D6h 0214 002h]                    PCI Path : 05,04


[0D8h 0216 001h]           Device Scope Type : 02 [PCI Bridge Device]
[0D9h 0217 001h]                Entry Length : 08
[0DAh 0218 001h]                       Flags : 00
[0DBh 0219 001h]                    Reserved : 00
[0DCh 0220 001h]              Enumeration ID : 00
[0DDh 0221 001h]              PCI Bus Number : D7

[0DEh 0222 002h]                    PCI Path : 00,00


[0E0h 0224 002h]               Subtable Type : 0000 [Hardware Unit Definition]
[0E2h 0226 002h]                      Length : 0018

[0E4h 0228 001h]                       Flags : 00
[0E5h 0229 001h]        Size (decoded below) : 00
                          Size (pages, log2) : 0
[0E6h 0230 002h]          PCI Segment Number : 0000
[0E8h 0232 008h]       Register Base Address : 00000000B7FFC000

[0F0h 0240 001h]           Device Scope Type : 03 [IOAPIC Device]
[0F1h 0241 001h]                Entry Length : 08
[0F2h 0242 001h]                       Flags : 00
[0F3h 0243 001h]                    Reserved : 00
[0F4h 0244 001h]              Enumeration ID : 0A
[0F5h 0245 001h]              PCI Bus Number : 17

[0F6h 0246 002h]                    PCI Path : 05,04


[0F8h 0248 002h]               Subtable Type : 0000 [Hardware Unit Definition]
[0FAh 0250 002h]                      Length : 0018

[0FCh 0252 001h]                       Flags : 00
[0FDh 0253 001h]        Size (decoded below) : 00
                          Size (pages, log2) : 0
[0FEh 0254 002h]          PCI Segment Number : 0000
[100h 0256 008h]       Register Base Address : 00000000BA7FC000

[108h 0264 001h]           Device Scope Type : 03 [IOAPIC Device]
[109h 0265 001h]                Entry Length : 08
[10Ah 0266 001h]                       Flags : 00
[10Bh 0267 001h]                    Reserved : 00
[10Ch 0268 001h]              Enumeration ID : 0B
[10Dh 0269 001h]              PCI Bus Number : 3A

[10Eh 0270 002h]                    PCI Path : 05,04


[110h 0272 002h]               Subtable Type : 0000 [Hardware Unit Definition]
[112h 0274 002h]                      Length : 0020

[114h 0276 001h]                       Flags : 00
[115h 0277 001h]        Size (decoded below) : 00
                          Size (pages, log2) : 0
[116h 0278 002h]          PCI Segment Number : 0000
[118h 0280 008h]       Register Base Address : 00000000BCFFC000

[120h 0288 001h]           Device Scope Type : 03 [IOAPIC Device]
[121h 0289 001h]                Entry Length : 08
[122h 0290 001h]                       Flags : 00
[123h 0291 001h]                    Reserved : 00
[124h 0292 001h]              Enumeration ID : 0C
[125h 0293 001h]              PCI Bus Number : 5D

[126h 0294 002h]                    PCI Path : 05,04


[128h 0296 001h]           Device Scope Type : 02 [PCI Bridge Device]
[129h 0297 001h]                Entry Length : 08
[12Ah 0298 001h]                       Flags : 00
[12Bh 0299 001h]                    Reserved : 00
[12Ch 0300 001h]              Enumeration ID : 00
[12Dh 0301 001h]              PCI Bus Number : 5D

[12Eh 0302 002h]                    PCI Path : 00,00


[130h 0304 002h]               Subtable Type : 0000 [Hardware Unit Definition]
[132h 0306 002h]                      Length : 0028

[134h 0308 001h]                       Flags : 01
[135h 0309 001h]        Size (decoded below) : 00
                          Size (pages, log2) : 0
[136h 0310 002h]          PCI Segment Number : 0000
[138h 0312 008h]       Register Base Address : 00000000943FC000

[140h 0320 001h]           Device Scope Type : 03 [IOAPIC Device]
[141h 0321 001h]                Entry Length : 08
[142h 0322 001h]                       Flags : 00
[143h 0323 001h]                    Reserved : 00
[144h 0324 001h]              Enumeration ID : 08
[145h 0325 001h]              PCI Bus Number : F0

[146h 0326 002h]                    PCI Path : 1F,00


[148h 0328 001h]           Device Scope Type : 03 [IOAPIC Device]
[149h 0329 001h]                Entry Length : 08
[14Ah 0330 001h]                       Flags : 00
[14Bh 0331 001h]                    Reserved : 00
[14Ch 0332 001h]              Enumeration ID : 09
[14Dh 0333 001h]              PCI Bus Number : 00

[14Eh 0334 002h]                    PCI Path : 05,04


[150h 0336 001h]           Device Scope Type : 04 [Message-capable HPET Device]
[151h 0337 001h]                Entry Length : 08
[152h 0338 001h]                       Flags : 00
[153h 0339 001h]                    Reserved : 00
[154h 0340 001h]              Enumeration ID : 00
[155h 0341 001h]              PCI Bus Number : 00

[156h 0342 002h]                    PCI Path : 1F,00


[158h 0344 002h]               Subtable Type : 0001 [Reserved Memory Region]
[15Ah 0346 002h]                      Length : 0020

[15Ch 0348 002h]                    Reserved : 0000
[15Eh 0350 002h]          PCI Segment Number : 0000
[160h 0352 008h]                Base Address : 000000006CCEB000
[168h 0360 008h]         End Address (limit) : 000000006CCFBFFF

[170h 0368 001h]           Device Scope Type : 01 [PCI Endpoint Device]
[171h 0369 001h]                Entry Length : 08
[172h 0370 001h]                       Flags : 00
[173h 0371 001h]                    Reserved : 00
[174h 0372 001h]              Enumeration ID : 00
[175h 0373 001h]              PCI Bus Number : 00

[176h 0374 002h]                    PCI Path : 14,00


[178h 0376 002h]               Subtable Type : 0002 [Root Port ATS Capability]
[17Ah 0378 002h]                      Length : 0010

[17Ch 0380 001h]                       Flags : 00
[17Dh 0381 001h]                    Reserved : 00
[17Eh 0382 002h]          PCI Segment Number : 0000

[180h 0384 001h]           Device Scope Type : 02 [PCI Bridge Device]
[181h 0385 001h]                Entry Length : 08
[182h 0386 001h]                       Flags : 00
[183h 0387 001h]                    Reserved : 00
[184h 0388 001h]              Enumeration ID : 00
[185h 0389 001h]              PCI Bus Number : 5D

[186h 0390 002h]                    PCI Path : 00,00


[188h 0392 002h]               Subtable Type : 0002 [Root Port ATS Capability]
[18Ah 0394 002h]                      Length : 0018

[18Ch 0396 001h]                       Flags : 00
[18Dh 0397 001h]                    Reserved : 00
[18Eh 0398 002h]          PCI Segment Number : 0000

[190h 0400 001h]           Device Scope Type : 02 [PCI Bridge Device]
[191h 0401 001h]                Entry Length : 08
[192h 0402 001h]                       Flags : 00
[193h 0403 001h]                    Reserved : 00
[194h 0404 001h]              Enumeration ID : 00
[195h 0405 001h]              PCI Bus Number : AE

[196h 0406 002h]                    PCI Path : 00,00


[198h 0408 001h]           Device Scope Type : 02 [PCI Bridge Device]
[199h 0409 001h]                Entry Length : 08
[19Ah 0410 001h]                       Flags : 00
[19Bh 0411 001h]                    Reserved : 00
[19Ch 0412 001h]              Enumeration ID : 00
[19Dh 0413 001h]              PCI Bus Number : D7

[19Eh 0414 002h]                    PCI Path : 00,00


[1A0h 0416 002h]               Subtable Type : 0003 [Remapping Hardware Static Affinity]
[1A2h 0418 002h]                      Length : 0014

[1A4h 0420 004h]                    Reserved : 00000000
[1A8h 0424 008h]                Base Address : 00000000943FC000
[1B0h 0432 004h]            Proximity Domain : 00000000

[1B4h 0436 002h]               Subtable Type : 0003 [Remapping Hardware Static Affinity]
[1B6h 0438 002h]                      Length : 0014

[1B8h 0440 004h]                    Reserved : 00000000
[1BCh 0444 008h]                Base Address : 00000000B7FFC000
[1C4h 0452 004h]            Proximity Domain : 00000000

[1C8h 0456 002h]               Subtable Type : 0003 [Remapping Hardware Static Affinity]
[1CAh 0458 002h]                      Length : 0014

[1CCh 0460 004h]                    Reserved : 00000000
[1D0h 0464 008h]                Base Address : 00000000BA7FC000
[1D8h 0472 004h]            Proximity Domain : 00000000

[1DCh 0476 002h]               Subtable Type : 0003 [Remapping Hardware Static Affinity]
[1DEh 0478 002h]                      Length : 0014

[1E0h 0480 004h]                    Reserved : 00000000
[1E4h 0484 008h]                Base Address : 00000000BCFFC000
[1ECh 0492 004h]            Proximity Domain : 00000000

[1F0h 0496 002h]               Subtable Type : 0003 [Remapping Hardware Static Affinity]
[1F2h 0498 002h]                      Length : 0014

[1F4h 0500 004h]                    Reserved : 00000000
[1F8h 0504 008h]                Base Address : 00000000BD3FC000
[200h 0512 004h]            Proximity Domain : 00000001

[204h 0516 002h]               Subtable Type : 0003 [Remapping Hardware Static Affinity]
[206h 0518 002h]                      Length : 0014

[208h 0520 004h]                    Reserved : 00000000
[20Ch 0524 008h]                Base Address : 00000000BD7FC000
[214h 0532 004h]            Proximity Domain : 00000001

[218h 0536 002h]               Subtable Type : 0003 [Remapping Hardware Static Affinity]
[21Ah 0538 002h]                      Length : 0014

[21Ch 0540 004h]                    Reserved : 00000000
[220h 0544 008h]                Base Address : 00000000D07FC000
[228h 0552 004h]            Proximity Domain : 00000001

[22Ch 0556 002h]               Subtable Type : 0003 [Remapping Hardware Static Affinity]
[22Eh 0558 002h]                      Length : 0014

[230h 0560 004h]                    Reserved : 00000000
[234h 0564 008h]                Base Address : 00000000FBFFC000
[23Ch 0572 004h]            Proximity Domain : 00000001

Raw Table Data: Length 576 (0x240)

    0000: 44 4D 41 52 40 02 00 00 01 C0 41 4C 41 53 4B 41  // DMAR@.....ALASKA
    0010: 41 20 4D 20 49 20 00 00 01 00 00 00 49 4E 54 4C  // A M I ......INTL
    0020: 13 10 09 20 2D 01 00 00 00 00 00 00 00 00 00 00  // ... -...........
    0030: 00 00 58 00 00 00 00 00 00 C0 3F BD 00 00 00 00  // ..X.......?.....
    0040: 03 08 00 00 0F 80 05 04 01 08 00 00 00 80 04 00  // ................
    0050: 01 08 00 00 00 80 04 01 01 08 00 00 00 80 04 02  // ................
    0060: 01 08 00 00 00 80 04 03 01 08 00 00 00 80 04 04  // ................
    0070: 01 08 00 00 00 80 04 05 01 08 00 00 00 80 04 06  // ................
    0080: 01 08 00 00 00 80 04 07 00 00 18 00 00 00 00 00  // ................
    0090: 00 C0 7F BD 00 00 00 00 03 08 00 00 10 85 05 04  // ................
    00A0: 00 00 20 00 00 00 00 00 00 C0 7F D0 00 00 00 00  // .. .............
    00B0: 03 08 00 00 11 AE 05 04 02 08 00 00 00 AE 00 00  // ................
    00C0: 00 00 20 00 00 00 00 00 00 C0 FF FB 00 00 00 00  // .. .............
    00D0: 03 08 00 00 12 D7 05 04 02 08 00 00 00 D7 00 00  // ................
    00E0: 00 00 18 00 00 00 00 00 00 C0 FF B7 00 00 00 00  // ................
    00F0: 03 08 00 00 0A 17 05 04 00 00 18 00 00 00 00 00  // ................
    0100: 00 C0 7F BA 00 00 00 00 03 08 00 00 0B 3A 05 04  // .............:..
    0110: 00 00 20 00 00 00 00 00 00 C0 FF BC 00 00 00 00  // .. .............
    0120: 03 08 00 00 0C 5D 05 04 02 08 00 00 00 5D 00 00  // .....].......]..
    0130: 00 00 28 00 01 00 00 00 00 C0 3F 94 00 00 00 00  // ..(.......?.....
    0140: 03 08 00 00 08 F0 1F 00 03 08 00 00 09 00 05 04  // ................
    0150: 04 08 00 00 00 00 1F 00 01 00 20 00 00 00 00 00  // .......... .....
    0160: 00 B0 CE 6C 00 00 00 00 FF BF CF 6C 00 00 00 00  // ...l.......l....
    0170: 01 08 00 00 00 00 14 00 02 00 10 00 00 00 00 00  // ................
    0180: 02 08 00 00 00 5D 00 00 02 00 18 00 00 00 00 00  // .....]..........
    0190: 02 08 00 00 00 AE 00 00 02 08 00 00 00 D7 00 00  // ................
    01A0: 03 00 14 00 00 00 00 00 00 C0 3F 94 00 00 00 00  // ..........?.....
    01B0: 00 00 00 00 03 00 14 00 00 00 00 00 00 C0 FF B7  // ................
    01C0: 00 00 00 00 00 00 00 00 03 00 14 00 00 00 00 00  // ................
    01D0: 00 C0 7F BA 00 00 00 00 00 00 00 00 03 00 14 00  // ................
    01E0: 00 00 00 00 00 C0 FF BC 00 00 00 00 00 00 00 00  // ................
    01F0: 03 00 14 00 00 00 00 00 00 C0 3F BD 00 00 00 00  // ..........?.....
    0200: 01 00 00 00 03 00 14 00 00 00 00 00 00 C0 7F BD  // ................
    0210: 00 00 00 00 01 00 00 00 03 00 14 00 00 00 00 00  // ................
    0220: 00 C0 7F D0 00 00 00 00 01 00 00 00 03 00 14 00  // ................
    0230: 00 00 00 00 00 C0 FF FB 00 00 00 00 01 00 00 00  // ................
