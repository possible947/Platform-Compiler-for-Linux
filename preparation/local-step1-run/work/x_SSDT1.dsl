/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20260930 (64-bit version)
 * Copyright (c) 2000 - 2026 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ../../../ACPI/SSDT1.aml
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000046C (1132)
 *     Revision         0x02
 *     Checksum         0x36
 *     OEM ID           "INTEL"
 *     OEM Table ID     "ADDRXLAT"
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20140828 (538183720)
 */
DefinitionBlock ("", "SSDT", 2, "INTEL", "ADDRXLAT", 0x00000001)
{
    Scope (\_SB)
    {
        Device (ADXL)
        {
            Name (_HID, "INTL0000")  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0B)
            }

            OperationRegion (BUFF, SystemMemory, 0x6830B018, 0x00000104)
            Field (BUFF, AnyAcc, NoLock, Preserve)
            {
                SWSM,   32, 
                CMD,    32, 
                STS,    32, 
                SYSA,   64, 
                NMSA,   64, 
                SPSA,   64, 
                DPA,    64, 
                PSKT,   64, 
                MCID,   64, 
                TID,    64, 
                LCID,   64, 
                CA,     64, 
                NMCA,   64, 
                CID,    64, 
                NCID,   64, 
                RA,     64, 
                NMRA,   64, 
                PRID,   64, 
                NPRI,   64, 
                SLOT,   64, 
                NMSL,   64, 
                DRID,   64, 
                ROW,    64, 
                COL,    64, 
                BANK,   64, 
                BG,     64, 
                LSR,    64, 
                LSPR,   64, 
                LSB,    64, 
                LSBG,   64, 
                CS,     64, 
                NMCS,   64, 
                NODE,   64, 
                CHIP,   64
            }

            Name (PRMS, Package (0x1F)
            {
                "SystemAddress", 
                "NmSystemAddress", 
                "SpareSystemAddress", 
                "DevicePhysicalAddress", 
                "ProcessorSocketId", 
                "MemoryControllerId", 
                "TargetId", 
                "LogicalChannelId", 
                "ChannelAddress", 
                "NmChannelAddress", 
                "ChannelId", 
                "NmChannelId", 
                "RankAddress", 
                "NmRankAddress", 
                "PhysicalRankId", 
                "NmPhysicalRankId", 
                "DimmSlotId", 
                "NmDimmSlotId", 
                "DimmRankId", 
                "Row", 
                "Column", 
                "Bank", 
                "BankGroup", 
                "LockStepRank", 
                "LockStepPhysicalRank", 
                "LockStepBank", 
                "LockStepBankGroup", 
                "ChipSelect", 
                "NmChipSelect", 
                "Node", 
                "ChipId"
            })
            Name (SUCC, Zero)
            Name (UNKN, One)
            Name (INVC, 0x02)
            Name (INTE, 0x03)
            OperationRegion (SMIP, SystemIO, 0xB2, One)
            Field (SMIP, ByteAcc, NoLock, Preserve)
            {
                IOB2,   8
            }

            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If (((Arg0 == ToUUID ("aa3c050a-7ea4-4c1f-afda-1267dfd3d48d") /* Unknown UUID */) && (Arg1 == One)))
                {
                    Switch (ToInteger (Arg2))
                    {
                        Case (Zero)
                        {
                            Return (Buffer (One)
                            {
                                 0x07                                             // .
                            })
                        }
                        Case (One)
                        {
                            Return (Package (0x02)
                            {
                                SUCC, , 
                                PRMS, 
                            })
                        }
                        Case (0x02)
                        {
                            If (~(SizeOf (Arg3) == One))
                            {
                                Return (Package (0x02)
                                {
                                    UNKN, , 
                                    Package (0x1F){}
                                })
                            }

                            CMD = 0x02
                            SYSA = DerefOf (Arg3 [Zero])
                            IOB2 = SWSM /* \_SB_.ADXL.SWSM */
                            Return (Package (0x02)
                            {
                                STS, , 
                                Package (0x1F)
                                {
                                    SYSA, , 
                                    NMSA, , 
                                    SPSA, , 
                                    DPA, , 
                                    PSKT, , 
                                    MCID, , 
                                    TID, , 
                                    LCID, , 
                                    CA, , 
                                    NMCA, , 
                                    CID, , 
                                    NCID, , 
                                    RA, , 
                                    NMRA, , 
                                    PRID, , 
                                    NPRI, , 
                                    SLOT, , 
                                    NMSL, , 
                                    DRID, , 
                                    ROW, , 
                                    COL, , 
                                    BANK, , 
                                    BG, , 
                                    LSR, , 
                                    LSPR, , 
                                    LSB, , 
                                    LSBG, , 
                                    CS, , 
                                    NMCS, , 
                                    NODE, , 
                                    CHIP, 
                                }
                            })
                        }
                        Case (0x03)
                        {
                            Return (Package (0x02)
                            {
                                INVC, , 
                                Package (0x1F){}
                            })
                        }
                        Default
                        {
                            BreakPoint
                            Return (Package (0x02)
                            {
                                INVC, , 
                                Package (0x1F){}
                            })
                        }

                    }
                }
                Else
                {
                    BreakPoint
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }
        }
    }
}

