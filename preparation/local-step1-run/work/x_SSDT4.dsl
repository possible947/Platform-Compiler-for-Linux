/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20260930 (64-bit version)
 * Copyright (c) 2000 - 2026 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ../../../ACPI/SSDT4.aml
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00001B4E (6990)
 *     Revision         0x02
 *     Checksum         0x5C
 *     OEM ID           "INTEL"
 *     OEM Table ID     "SpsNm   "
 *     OEM Revision     0x00000002 (2)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20140828 (538183720)
 */
DefinitionBlock ("", "SSDT", 2, "INTEL", "SpsNm   ", 0x00000002)
{
    External (_SB_.PC00.HEC1, DeviceObj)
    External (_SB_.PC00.HEC2, DeviceObj)
    External (_SB_.SCK0.CP00, UnknownObj)
    External (_SB_.SCK0.CP01, UnknownObj)
    External (_SB_.SCK0.CP02, UnknownObj)
    External (_SB_.SCK0.CP03, UnknownObj)
    External (_SB_.SCK0.CP04, UnknownObj)
    External (_SB_.SCK0.CP05, UnknownObj)
    External (_SB_.SCK0.CP06, UnknownObj)
    External (_SB_.SCK0.CP07, UnknownObj)
    External (_SB_.SCK0.CP08, UnknownObj)
    External (_SB_.SCK0.CP09, UnknownObj)
    External (_SB_.SCK0.CP0A, UnknownObj)
    External (_SB_.SCK0.CP0B, UnknownObj)
    External (_SB_.SCK0.CP0C, UnknownObj)
    External (_SB_.SCK0.CP0D, UnknownObj)
    External (_SB_.SCK0.CP0E, UnknownObj)
    External (_SB_.SCK0.CP0F, UnknownObj)
    External (_SB_.SCK0.CP10, UnknownObj)
    External (_SB_.SCK0.CP11, UnknownObj)
    External (_SB_.SCK0.CP12, UnknownObj)
    External (_SB_.SCK0.CP13, UnknownObj)
    External (_SB_.SCK0.CP14, UnknownObj)
    External (_SB_.SCK0.CP15, UnknownObj)
    External (_SB_.SCK0.CP16, UnknownObj)
    External (_SB_.SCK0.CP17, UnknownObj)
    External (_SB_.SCK0.CP18, UnknownObj)
    External (_SB_.SCK0.CP19, UnknownObj)
    External (_SB_.SCK0.CP1A, UnknownObj)
    External (_SB_.SCK0.CP1B, UnknownObj)
    External (_SB_.SCK0.CP1C, UnknownObj)
    External (_SB_.SCK0.CP1D, UnknownObj)
    External (_SB_.SCK0.CP1E, UnknownObj)
    External (_SB_.SCK0.CP1F, UnknownObj)
    External (_SB_.SCK0.CP20, UnknownObj)
    External (_SB_.SCK0.CP21, UnknownObj)
    External (_SB_.SCK0.CP22, UnknownObj)
    External (_SB_.SCK0.CP23, UnknownObj)
    External (_SB_.SCK0.CP24, UnknownObj)
    External (_SB_.SCK0.CP25, UnknownObj)
    External (_SB_.SCK0.CP26, UnknownObj)
    External (_SB_.SCK0.CP27, UnknownObj)
    External (_SB_.SCK0.CP28, UnknownObj)
    External (_SB_.SCK0.CP29, UnknownObj)
    External (_SB_.SCK0.CP2A, UnknownObj)
    External (_SB_.SCK0.CP2B, UnknownObj)
    External (_SB_.SCK0.CP2C, UnknownObj)
    External (_SB_.SCK0.CP2D, UnknownObj)
    External (_SB_.SCK0.CP2E, UnknownObj)
    External (_SB_.SCK0.CP2F, UnknownObj)
    External (_SB_.SCK0.CP30, UnknownObj)
    External (_SB_.SCK0.CP31, UnknownObj)
    External (_SB_.SCK0.CP32, UnknownObj)
    External (_SB_.SCK0.CP33, UnknownObj)
    External (_SB_.SCK0.CP34, UnknownObj)
    External (_SB_.SCK0.CP35, UnknownObj)
    External (_SB_.SCK0.CP36, UnknownObj)
    External (_SB_.SCK0.CP37, UnknownObj)
    External (_SB_.SCK1.CP00, UnknownObj)
    External (_SB_.SCK1.CP01, UnknownObj)
    External (_SB_.SCK1.CP02, UnknownObj)
    External (_SB_.SCK1.CP03, UnknownObj)
    External (_SB_.SCK1.CP04, UnknownObj)
    External (_SB_.SCK1.CP05, UnknownObj)
    External (_SB_.SCK1.CP06, UnknownObj)
    External (_SB_.SCK1.CP07, UnknownObj)
    External (_SB_.SCK1.CP08, UnknownObj)
    External (_SB_.SCK1.CP09, UnknownObj)
    External (_SB_.SCK1.CP0A, UnknownObj)
    External (_SB_.SCK1.CP0B, UnknownObj)
    External (_SB_.SCK1.CP0C, UnknownObj)
    External (_SB_.SCK1.CP0D, UnknownObj)
    External (_SB_.SCK1.CP0E, UnknownObj)
    External (_SB_.SCK1.CP0F, UnknownObj)
    External (_SB_.SCK1.CP10, UnknownObj)
    External (_SB_.SCK1.CP11, UnknownObj)
    External (_SB_.SCK1.CP12, UnknownObj)
    External (_SB_.SCK1.CP13, UnknownObj)
    External (_SB_.SCK1.CP14, UnknownObj)
    External (_SB_.SCK1.CP15, UnknownObj)
    External (_SB_.SCK1.CP16, UnknownObj)
    External (_SB_.SCK1.CP17, UnknownObj)
    External (_SB_.SCK1.CP18, UnknownObj)
    External (_SB_.SCK1.CP19, UnknownObj)
    External (_SB_.SCK1.CP1A, UnknownObj)
    External (_SB_.SCK1.CP1B, UnknownObj)
    External (_SB_.SCK1.CP1C, UnknownObj)
    External (_SB_.SCK1.CP1D, UnknownObj)
    External (_SB_.SCK1.CP1E, UnknownObj)
    External (_SB_.SCK1.CP1F, UnknownObj)
    External (_SB_.SCK1.CP20, UnknownObj)
    External (_SB_.SCK1.CP21, UnknownObj)
    External (_SB_.SCK1.CP22, UnknownObj)
    External (_SB_.SCK1.CP23, UnknownObj)
    External (_SB_.SCK1.CP24, UnknownObj)
    External (_SB_.SCK1.CP25, UnknownObj)
    External (_SB_.SCK1.CP26, UnknownObj)
    External (_SB_.SCK1.CP27, UnknownObj)
    External (_SB_.SCK1.CP28, UnknownObj)
    External (_SB_.SCK1.CP29, UnknownObj)
    External (_SB_.SCK1.CP2A, UnknownObj)
    External (_SB_.SCK1.CP2B, UnknownObj)
    External (_SB_.SCK1.CP2C, UnknownObj)
    External (_SB_.SCK1.CP2D, UnknownObj)
    External (_SB_.SCK1.CP2E, UnknownObj)
    External (_SB_.SCK1.CP2F, UnknownObj)
    External (_SB_.SCK1.CP30, UnknownObj)
    External (_SB_.SCK1.CP31, UnknownObj)
    External (_SB_.SCK1.CP32, UnknownObj)
    External (_SB_.SCK1.CP33, UnknownObj)
    External (_SB_.SCK1.CP34, UnknownObj)
    External (_SB_.SCK1.CP35, UnknownObj)
    External (_SB_.SCK1.CP36, UnknownObj)
    External (_SB_.SCK1.CP37, UnknownObj)
    External (HWEN, UnknownObj)
    External (PETE, UnknownObj)
    External (PSLM, UnknownObj)
    External (TSLM, UnknownObj)

    Scope (\)
    {
        Name (PURA, Zero)
        Name (PURB, Zero)
        Name (PURE, Zero)
        Name (THNU, 0x0050)
    }

    Scope (\_SB.PC00.HEC1)
    {
        OperationRegion (MFS1, PCI_Config, 0x40, 0x04)
        Field (MFS1, DWordAcc, NoLock, Preserve)
        {
            MEFS,   32
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If ((MEFS == 0xFFFFFFFF))
            {
                Return (Zero)
            }

            Return (0x0F)
        }
    }

    Scope (\_SB.PC00.HEC2)
    {
        Name (H2ST, 0x0B)
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (H2ST) /* \_SB_.PC00.HEC2.H2ST */
        }

        OperationRegion (H2CS, SystemMemory, 0x0000383FFFF45000, 0x10)
        Field (H2CS, DWordAcc, NoLock, Preserve)
        {
            CBWW,   32, 
            HIE,    1, 
            HIS,    1, 
            HIG,    1, 
            HRD,    1, 
            HRS,    1, 
            Offset (0x05), 
            HRP,    8, 
            HWP,    8, 
            HBD,    8, 
            CBRW,   32, 
            MIE,    1, 
            MIS,    1, 
            MIG,    1, 
            MRD,    1, 
            MRS,    1, 
            Offset (0x0D), 
            MRP,    8, 
            MWP,    8, 
            MBD,    8
        }

        Method (_INI, 0, Serialized)  // _INI: Initialize
        {
            If ((HWEN > One))
            {
                PETE |= One
            }

            HWAK ()
        }

        Method (HWAK, 0, Serialized)
        {
            If ((H2ST & 0x0B))
            {
                HRD = One
                HIE = One
                HIG = One
            }
        }

        Method (HPTS, 0, Serialized)
        {
            If ((H2ST & 0x0B))
            {
                HIE = Zero
                HRD = Zero
                HIG = One
            }
        }

        Method (SEND, 1, Serialized)
        {
            If ((HRD && MRD))
            {
                CBWW = 0x80040011
                CBWW = Arg0
                HIG = One
            }
        }

        Method (RSET, 0, Serialized)
        {
            HIS = One
            HRS = One
            HIG = One
        }

        Method (H2RD, 0, Serialized)
        {
            If (!(H2ST & 0x0B))
            {
                Return (0xFF)
            }

            If (MRS)
            {
                RSET ()
            }
            ElseIf (MRD)
            {
                If (!HRD)
                {
                    HRS = Zero
                    HRD = One
                    HIG = One
                }

                If ((MWP != MRP))
                {
                    Local0 = CBRW /* \_SB_.PC00.HEC2.CBRW */
                    Local1 = CBRW /* \_SB_.PC00.HEC2.CBRW */
                    HIG = One
                    Local6 = (Local0 & 0x01FF0000)
                    Local7 = (Local1 & 0xFF)
                    If ((Local7 == Zero))
                    {
                        If ((Local6 == 0x00040000))
                        {
                            Local2 = (Local1 & 0x00FF0000)
                            Local2 |= ((Local1 & 0x00FF0000) << 0x08)
                            Local2 |= ((Local1 & 0x00FF0000) >> 0x08)
                            Local2 |= ((Local1 & 0x00FF0000) >> 0x10)
                            Local3 = Local2
                            Local4 = (Local1 & 0xFF000000)
                            Local4 |= ((Local1 & 0xFF000000) >> 0x08)
                            Local4 |= ((Local1 & 0xFF000000) >> 0x10)
                            Local4 |= ((Local1 & 0xFF000000) >> 0x18)
                            Local5 = Local4
                        }
                        ElseIf ((Local6 == 0x00140000))
                        {
                            Local2 = CBRW /* \_SB_.PC00.HEC2.CBRW */
                            Local3 = CBRW /* \_SB_.PC00.HEC2.CBRW */
                            Local4 = CBRW /* \_SB_.PC00.HEC2.CBRW */
                            Local5 = CBRW /* \_SB_.PC00.HEC2.CBRW */
                        }
                        Else
                        {
                            RSET ()
                            Return (0xFF)
                        }

                        If ((\PETE & 0x80))
                        {
                            \PSLM [Zero] = (Local2 & 0xFF)
                            \PSLM [One] = ((Local2 >> 0x08) & 0xFF)
                            \PSLM [0x02] = ((Local2 >> 0x10) & 0xFF)
                            \PSLM [0x03] = ((Local2 >> 0x18) & 0xFF)
                            \PSLM [0x04] = (Local3 & 0xFF)
                            \PSLM [0x05] = ((Local3 >> 0x08) & 0xFF)
                            \PSLM [0x06] = ((Local3 >> 0x10) & 0xFF)
                            \PSLM [0x07] = ((Local3 >> 0x18) & 0xFF)
                            Notify (\_SB.SCK0.CP00, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP01, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP02, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP03, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP04, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP05, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP06, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP07, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP08, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP09, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP0A, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP0B, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP0C, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP0D, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP0E, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP0F, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP10, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP11, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP12, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP13, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP14, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP15, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP16, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP17, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP18, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP19, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP1A, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP1B, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP1C, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP1D, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP1E, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP1F, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP20, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP21, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP22, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP23, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP24, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP25, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP26, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP27, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP28, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP29, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP2A, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP2B, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP2C, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP2D, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP2E, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP2F, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP30, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP31, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP32, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP33, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP34, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP35, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP36, 0x80) // Status Change
                            Notify (\_SB.SCK0.CP37, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP00, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP01, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP02, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP03, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP04, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP05, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP06, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP07, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP08, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP09, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP0A, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP0B, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP0C, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP0D, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP0E, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP0F, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP10, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP11, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP12, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP13, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP14, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP15, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP16, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP17, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP18, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP19, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP1A, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP1B, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP1C, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP1D, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP1E, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP1F, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP20, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP21, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP22, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP23, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP24, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP25, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP26, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP27, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP28, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP29, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP2A, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP2B, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP2C, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP2D, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP2E, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP2F, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP30, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP31, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP32, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP33, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP34, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP35, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP36, 0x80) // Status Change
                            Notify (\_SB.SCK1.CP37, 0x80) // Status Change
                        }

                        If ((\PETE & 0x40))
                        {
                            \TSLM [Zero] = (Local4 & 0xFF)
                            \TSLM [One] = ((Local4 >> 0x08) & 0xFF)
                            \TSLM [0x02] = ((Local4 >> 0x10) & 0xFF)
                            \TSLM [0x03] = ((Local4 >> 0x18) & 0xFF)
                            \TSLM [0x04] = (Local5 & 0xFF)
                            \TSLM [0x05] = ((Local5 >> 0x08) & 0xFF)
                            \TSLM [0x06] = ((Local5 >> 0x10) & 0xFF)
                            \TSLM [0x07] = ((Local5 >> 0x18) & 0xFF)
                            Notify (\_SB.SCK0.CP00, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP01, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP02, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP03, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP04, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP05, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP06, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP07, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP08, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP09, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP0A, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP0B, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP0C, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP0D, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP0E, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP0F, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP10, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP11, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP12, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP13, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP14, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP15, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP16, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP17, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP18, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP19, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP1A, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP1B, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP1C, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP1D, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP1E, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP1F, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP20, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP21, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP22, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP23, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP24, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP25, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP26, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP27, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP28, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP29, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP2A, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP2B, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP2C, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP2D, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP2E, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP2F, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP30, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP31, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP32, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP33, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP34, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP35, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP36, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK0.CP37, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP00, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP01, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP02, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP03, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP04, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP05, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP06, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP07, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP08, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP09, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP0A, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP0B, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP0C, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP0D, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP0E, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP0F, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP10, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP11, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP12, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP13, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP14, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP15, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP16, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP17, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP18, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP19, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP1A, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP1B, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP1C, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP1D, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP1E, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP1F, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP20, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP21, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP22, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP23, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP24, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP25, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP26, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP27, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP28, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP29, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP2A, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP2B, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP2C, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP2D, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP2E, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP2F, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP30, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP31, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP32, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP33, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP34, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP35, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP36, 0x82) // Device-Specific Change
                            Notify (\_SB.SCK1.CP37, 0x82) // Device-Specific Change
                        }

                        SEND ((Local1 | \PETE))
                    }
                    ElseIf (((Local7 == 0x03) && (Local6 == 0x00040000)))
                    {
                        If (\PURE)
                        {
                            \PURA = Local1
                            Notify (\_SB.PRAD, 0x80) // Status Change
                        }
                        Else
                        {
                            SEND (Local1)
                        }
                    }
                    ElseIf (((Local7 == 0x04) && (Local6 == 0x00040000)))
                    {
                        PWR = (((Local1 >> 0x10) & 0xFFFF) * 0x03E8)
                        SEND ((Local1 | 0x80))
                    }
                    ElseIf (((Local7 == 0x05) && (Local6 == 0x00040000)))
                    {
                        PMAI = (((Local1 >> 0x10) & 0xFFFF) * 0x03E8)
                        SEND ((Local1 | 0x80))
                        Notify (\_SB.PMT1, 0x84) // Reserved
                    }
                    ElseIf (((Local7 == 0x06) && (Local6 == 0x00040000)))
                    {
                        HWL = (((Local1 >> 0x10) & 0xFFFF) * 0x03E8)
                        SEND ((Local1 | 0x80))
                        Notify (\_SB.PMT1, 0x82) // Device-Specific Change
                    }
                    ElseIf (((Local7 == 0x0E) && (Local6 == 0x00040000)))
                    {
                        SEND ((Local1 | 0x80))
                        If ((((Local1 >> 0x10) & One) == One))
                        {
                            Notify (\_SB.PMT1, 0x83) // Device-Specific Change
                        }
                    }
                    ElseIf (((Local7 == 0x0C) && (Local6 == 0x00040000)))
                    {
                        SEND (((PMAV << 0x10) | ((Local1 | 0x80) & 0xFFFF
                            )))
                        If ((One == PMAV))
                        {
                            If ((((Local1 >> 0x10) & 0xFF) == One))
                            {
                                \_SB.PC00.HEC2.SSFW (Zero, 0x08, Zero, Zero)
                            }

                            Local2 = (HWL / 0x03E8)
                            \_SB.PC00.HEC2.SSFW (Zero, 0x07, Local2, Zero)
                            Local2 = (PMAI / 0x03E8)
                            \_SB.PC00.HEC2.SSFW (Zero, 0x0A, Local2, Zero)
                            Local2 = (PTPU / 0x03E8)
                            Local3 = (PTPL / 0x03E8)
                            \_SB.PC00.HEC2.SSFW (One, 0x0B, Local2, Local3)
                        }
                    }
                    ElseIf ((((Local7 == 0x88) | (Local7 == 0x0D)) && (
                        Local6 == 0x00200000)))
                    {
                        PMCP [Zero] = ((Local1 >> 0x18) & 0xFF)
                        PMCP [0x02] = ((Local1 >> 0x88) & One)
                        If ((((Local1 >> 0x10) & One) == One))
                        {
                            PMCP [0x08] = 0xFFFFFFFF
                        }
                        Else
                        {
                            PMCP [0x08] = Zero
                        }

                        PMCP [0x03] = CBRW /* \_SB_.PC00.HEC2.CBRW */
                        PMCP [0x04] = CBRW /* \_SB_.PC00.HEC2.CBRW */
                        PMCP [0x05] = CBRW /* \_SB_.PC00.HEC2.CBRW */
                        PMCP [0x06] = CBRW /* \_SB_.PC00.HEC2.CBRW */
                        PMCP [0x07] = CBRW /* \_SB_.PC00.HEC2.CBRW */
                        PMCP [0x09] = CBRW /* \_SB_.PC00.HEC2.CBRW */
                        PMCP [0x0A] = CBRW /* \_SB_.PC00.HEC2.CBRW */
                        If ((Local7 == 0x0D))
                        {
                            SEND (((Local1 | 0x80) & 0xFFFF))
                        }
                        Else
                        {
                            HIG = One
                        }

                        PMAV = One
                        Notify (\_SB.PMT1, 0x80) // Status Change
                    }
                    ElseIf (((Local7 == 0x09) && (Local6 == 0x00040000)))
                    {
                        SEND ((Local1 | 0x80))
                        Notify (\_SB.PMT1, 0x81) // Information Change
                    }
                    ElseIf (((Local7 == 0x87) && (Local6 == 0x00040000)))
                    {
                        HLST = ((Local1 >> 0x08) & 0xFF)
                    }
                    ElseIf (((Local7 == 0x8A) && (Local6 == 0x00040000)))
                    {
                        AIST = ((Local1 >> 0x08) & 0xFF)
                    }
                    ElseIf (((Local7 == 0x8B) && (Local6 == 0x00040000)))
                    {
                        TPST = ((Local1 >> 0x08) & 0xFF)
                    }
                    Else
                    {
                        RSET ()
                        Return (0xFF)
                    }

                    Return (Local7)
                }
            }

            Return (0xFF)
        }

        Method (HSCI, 0, Serialized)
        {
            If (HIS)
            {
                HIS = One
                Local0 = 0x08
                While ((H2RD () != 0xFF))
                {
                    Local0--
                    If (!Local0)
                    {
                        RSET ()
                        Break
                    }
                }
            }

            Local0 = 0x012C
            While ((!HIE && Local0))
            {
                Local0--
                Sleep (0x0A)
                HIE = One
            }
        }

        Method (SSFW, 4, Serialized)
        {
            If ((HRD && MRD))
            {
                Local1 = HIE /* \_SB_.PC00.HEC2.HIE_ */
                HIE = Zero
                If ((Arg0 == Zero))
                {
                    CBWW = 0x80040011
                    CBWW = ((Arg2 << 0x10) | (Arg1 & 0xFF))
                }
                ElseIf ((Arg0 == One))
                {
                    CBWW = 0x80080011
                    CBWW = (Arg1 & 0xFF)
                    CBWW = ((Arg3 << 0x10) | (Arg2 & 0xFFFF))
                }

                HIG = One
                Local0 = Zero
                While ((Local0 != 0x0A))
                {
                    If ((One == HIS))
                    {
                        HIS = One
                        If ((H2RD () == (Arg1 | 0x80)))
                        {
                            Break
                        }
                    }

                    Local0 += One
                    Sleep (0x64)
                }

                HIE = Local1
            }
        }
    }

    Scope (\_SB)
    {
        Name (PWR, 0xFFFFFFFF)
        Name (PMAI, 0xFFFFFFFF)
        Name (HWL, 0xFFFFFFFF)
        Name (PTPU, Zero)
        Name (PTPL, Zero)
        Name (PMAV, Zero)
        Name (HLST, Zero)
        Name (AIST, Zero)
        Name (TPST, Zero)
        Name (PMCP, Package (0x0E)
        {
            Zero, 
            Zero, 
            Zero, 
            Zero, 
            0xFFFFFFFF, 
            Zero, 
            Zero, 
            0xFFFFFFFF, 
            Zero, 
            Zero, 
            Zero, 
            "Intel(R) Node Manager", 
            "", 
            "Meter measures total domain"
        })
        Device (PMT1)
        {
            Name (_HID, "ACPI000D" /* Power Meter Device */)  // _HID: Hardware ID
            Name (_UID, Zero)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return ((\_SB.PC00.HEC2._STA () | 0x04))
            }

            Method (_PMC, 0, NotSerialized)  // _PMC: Power Meter Capabilities
            {
                If ((PMAV == Zero))
                {
                    \_SB.PC00.HEC2.SSFW (Zero, 0x08, Zero, Zero)
                }

                Return (PMCP) /* \_SB_.PMCP */
            }

            Method (_PMD, 0, NotSerialized)  // _PMD: Power Metered Devices
            {
                Return (Package (0x01)
                {
                    \_SB, 
                })
            }

            Method (_PMM, 0, NotSerialized)  // _PMM: Power Meter Measurement
            {
                Return (PWR) /* \_SB_.PWR_ */
            }

            Method (_PAI, 1, NotSerialized)  // _PAI: Power Averaging Interval
            {
                Local0 = (Arg0 / 0x03E8)
                AIST = 0x02
                \_SB.PC00.HEC2.SSFW (Zero, 0x0A, Local0, Zero)
                If (((AIST & 0xFF) == Zero))
                {
                    PMAI = Arg0
                    Notify (\_SB.PMT1, 0x84) // Reserved
                }

                Return (AIST) /* \_SB_.AIST */
            }

            Method (_GAI, 0, NotSerialized)  // _GAI: Get Averaging Interval
            {
                Return (PMAI) /* \_SB_.PMAI */
            }

            Method (_PTP, 2, NotSerialized)  // _PTP: Power Trip Points
            {
                Local0 = (Arg0 / 0x03E8)
                Local1 = (Arg1 + 0x01F4)
                Local1 = (Arg1 / 0x03E8)
                TPST = 0x02
                \_SB.PC00.HEC2.SSFW (One, 0x0B, Local0, Local1)
                If (((TPST & 0xFF) == Zero))
                {
                    PTPU = Arg0
                    PTPL = Arg1
                }

                Return (TPST) /* \_SB_.TPST */
            }

            Method (_GHL, 0, NotSerialized)  // _GHL: Get Hardware Limit
            {
                Return (HWL) /* \_SB_.HWL_ */
            }

            Method (_SHL, 1, NotSerialized)  // _SHL: Set Hardware Limit
            {
                Local0 = (Arg0 / 0x03E8)
                HLST = 0x02
                \_SB.PC00.HEC2.SSFW (Zero, 0x07, Local0, Zero)
                If (((HLST & 0xFF) == Zero))
                {
                    HWL = Arg0
                }

                Return (HLST) /* \_SB_.HLST */
            }
        }
    }

    Scope (\_SB)
    {
        Device (PRAD)
        {
            Name (_HID, "ACPI000C" /* Processor Aggregator Device */)  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (\_OSI ("Processor Aggregator Device"))
                {
                    \PURE = One
                    Return ((\_SB.PC00.HEC2._STA () | 0x04))
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_PUR, 0, Serialized)  // _PUR: Processor Utilization Request
            {
                Name (IDL, Package (0x02)
                {
                    One, 
                    Zero
                })
                \PURB = ((\PURA | 0x80) & 0xFFFF)
                IDL [One] = ((\PURA >> 0x10) & 0xFFFF)
                Return (IDL) /* \_SB_.PRAD._PUR.IDL_ */
            }

            Method (_OST, 3, Serialized)  // _OST: OSPM Status Indication
            {
                If (((\PURB & 0xFF) == 0x83))
                {
                    Local0 = (\THNU - ToInteger (Arg2))
                    \PURB |= (Local0 << 0x10)
                    \_SB.PC00.HEC2.SEND (\PURB)
                }
            }
        }
    }

    Scope (\_GPE)
    {
        Method (_L6C, 0, Serialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
        {
            \_SB.PC00.HEC2.HSCI ()
        }
    }
}

