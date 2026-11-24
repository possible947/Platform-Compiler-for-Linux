/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20260930 (64-bit version)
 * Copyright (c) 2000 - 2026 Intel Corporation
 * 
 * Disassembly of ../../../ACPI/MSCT.aml
 *
 * ACPI Data Table [MSCT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "MSCT"    [Maximum System Characteristics Table]
[004h 0004 004h]                Table Length : 00000064
[008h 0008 001h]                    Revision : 01
[009h 0009 001h]                    Checksum : E8
[00Ah 0010 006h]                      Oem ID : "ALASKA"
[010h 0016 008h]                Oem Table ID : "A M I "
[018h 0024 004h]                Oem Revision : 00000001
[01Ch 0028 004h]             Asl Compiler ID : "INTL"
[020h 0032 004h]       Asl Compiler Revision : 20091013

[024h 0036 004h]            Proximity Offset : 00000038
[028h 0040 004h]       Max Proximity Domains : 00000001
[02Ch 0044 004h]           Max Clock Domains : 00000000
[030h 0048 008h]        Max Physical Address : 00003FFFFFFFFFFF

[038h 0056 001h]                    Revision : 01
[039h 0057 001h]                      Length : 16
[03Ah 0058 004h]          Domain Range Start : 00000000
[03Eh 0062 004h]            Domain Range End : 00000001
[042h 0066 004h]          Processor Capacity : 00000038
[046h 0070 008h]             Memory Capacity : 00003FFFFFFFFFFF

[04Eh 0078 001h]                    Revision : 01
[04Fh 0079 001h]                      Length : 16
[050h 0080 004h]          Domain Range Start : 00000000
[054h 0084 004h]            Domain Range End : 00000000
[058h 0088 004h]          Processor Capacity : 00000000
[05Ch 0092 008h]             Memory Capacity : 0000000000000000

Raw Table Data: Length 100 (0x64)

    0000: 4D 53 43 54 64 00 00 00 01 E8 41 4C 41 53 4B 41  // MSCTd.....ALASKA
    0010: 41 20 4D 20 49 20 00 00 01 00 00 00 49 4E 54 4C  // A M I ......INTL
    0020: 13 10 09 20 38 00 00 00 01 00 00 00 00 00 00 00  // ... 8...........
    0030: FF FF FF FF FF 3F 00 00 01 16 00 00 00 00 01 00  // .....?..........
    0040: 00 00 38 00 00 00 FF FF FF FF FF 3F 00 00 01 16  // ..8........?....
    0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0060: 00 00 00 00                                      // ....
