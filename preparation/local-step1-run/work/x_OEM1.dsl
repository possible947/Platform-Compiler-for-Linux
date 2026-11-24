/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20260930 (64-bit version)
 * Copyright (c) 2000 - 2026 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of ../../../ACPI/OEM1.aml
 *
 * Original Table Header:
 *     Signature        "OEM1"
 *     Length           0x00015174 (86388)
 *     Revision         0x02
 *     Checksum         0xA6
 *     OEM ID           "INTEL"
 *     OEM Table ID     "CPU EIST"
 *     OEM Revision     0x00003000 (12288)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20140828 (538183720)
 */
DefinitionBlock ("", "OEM1", 2, "INTEL", "CPU EIST", 0x00003000)
{
    External (_SB_.SCK0.CP00, DeviceObj)
    External (_SB_.SCK0.CP01, DeviceObj)
    External (_SB_.SCK0.CP02, DeviceObj)
    External (_SB_.SCK0.CP03, DeviceObj)
    External (_SB_.SCK0.CP04, DeviceObj)
    External (_SB_.SCK0.CP05, DeviceObj)
    External (_SB_.SCK0.CP06, DeviceObj)
    External (_SB_.SCK0.CP07, DeviceObj)
    External (_SB_.SCK0.CP08, DeviceObj)
    External (_SB_.SCK0.CP09, DeviceObj)
    External (_SB_.SCK0.CP0A, DeviceObj)
    External (_SB_.SCK0.CP0B, DeviceObj)
    External (_SB_.SCK0.CP0C, DeviceObj)
    External (_SB_.SCK0.CP0D, DeviceObj)
    External (_SB_.SCK0.CP0E, DeviceObj)
    External (_SB_.SCK0.CP0F, DeviceObj)
    External (_SB_.SCK0.CP10, DeviceObj)
    External (_SB_.SCK0.CP11, DeviceObj)
    External (_SB_.SCK0.CP12, DeviceObj)
    External (_SB_.SCK0.CP13, DeviceObj)
    External (_SB_.SCK0.CP14, DeviceObj)
    External (_SB_.SCK0.CP15, DeviceObj)
    External (_SB_.SCK0.CP16, DeviceObj)
    External (_SB_.SCK0.CP17, DeviceObj)
    External (_SB_.SCK0.CP18, DeviceObj)
    External (_SB_.SCK0.CP19, DeviceObj)
    External (_SB_.SCK0.CP1A, DeviceObj)
    External (_SB_.SCK0.CP1B, DeviceObj)
    External (_SB_.SCK0.CP1C, DeviceObj)
    External (_SB_.SCK0.CP1D, DeviceObj)
    External (_SB_.SCK0.CP1E, DeviceObj)
    External (_SB_.SCK0.CP1F, DeviceObj)
    External (_SB_.SCK0.CP20, DeviceObj)
    External (_SB_.SCK0.CP21, DeviceObj)
    External (_SB_.SCK0.CP22, DeviceObj)
    External (_SB_.SCK0.CP23, DeviceObj)
    External (_SB_.SCK0.CP24, DeviceObj)
    External (_SB_.SCK0.CP25, DeviceObj)
    External (_SB_.SCK0.CP26, DeviceObj)
    External (_SB_.SCK0.CP27, DeviceObj)
    External (_SB_.SCK0.CP28, DeviceObj)
    External (_SB_.SCK0.CP29, DeviceObj)
    External (_SB_.SCK0.CP2A, DeviceObj)
    External (_SB_.SCK0.CP2B, DeviceObj)
    External (_SB_.SCK0.CP2C, DeviceObj)
    External (_SB_.SCK0.CP2D, DeviceObj)
    External (_SB_.SCK0.CP2E, DeviceObj)
    External (_SB_.SCK0.CP2F, DeviceObj)
    External (_SB_.SCK0.CP30, DeviceObj)
    External (_SB_.SCK0.CP31, DeviceObj)
    External (_SB_.SCK0.CP32, DeviceObj)
    External (_SB_.SCK0.CP33, DeviceObj)
    External (_SB_.SCK0.CP34, DeviceObj)
    External (_SB_.SCK0.CP35, DeviceObj)
    External (_SB_.SCK0.CP36, DeviceObj)
    External (_SB_.SCK0.CP37, DeviceObj)
    External (_SB_.SCK1.CP00, DeviceObj)
    External (_SB_.SCK1.CP01, DeviceObj)
    External (_SB_.SCK1.CP02, DeviceObj)
    External (_SB_.SCK1.CP03, DeviceObj)
    External (_SB_.SCK1.CP04, DeviceObj)
    External (_SB_.SCK1.CP05, DeviceObj)
    External (_SB_.SCK1.CP06, DeviceObj)
    External (_SB_.SCK1.CP07, DeviceObj)
    External (_SB_.SCK1.CP08, DeviceObj)
    External (_SB_.SCK1.CP09, DeviceObj)
    External (_SB_.SCK1.CP0A, DeviceObj)
    External (_SB_.SCK1.CP0B, DeviceObj)
    External (_SB_.SCK1.CP0C, DeviceObj)
    External (_SB_.SCK1.CP0D, DeviceObj)
    External (_SB_.SCK1.CP0E, DeviceObj)
    External (_SB_.SCK1.CP0F, DeviceObj)
    External (_SB_.SCK1.CP10, DeviceObj)
    External (_SB_.SCK1.CP11, DeviceObj)
    External (_SB_.SCK1.CP12, DeviceObj)
    External (_SB_.SCK1.CP13, DeviceObj)
    External (_SB_.SCK1.CP14, DeviceObj)
    External (_SB_.SCK1.CP15, DeviceObj)
    External (_SB_.SCK1.CP16, DeviceObj)
    External (_SB_.SCK1.CP17, DeviceObj)
    External (_SB_.SCK1.CP18, DeviceObj)
    External (_SB_.SCK1.CP19, DeviceObj)
    External (_SB_.SCK1.CP1A, DeviceObj)
    External (_SB_.SCK1.CP1B, DeviceObj)
    External (_SB_.SCK1.CP1C, DeviceObj)
    External (_SB_.SCK1.CP1D, DeviceObj)
    External (_SB_.SCK1.CP1E, DeviceObj)
    External (_SB_.SCK1.CP1F, DeviceObj)
    External (_SB_.SCK1.CP20, DeviceObj)
    External (_SB_.SCK1.CP21, DeviceObj)
    External (_SB_.SCK1.CP22, DeviceObj)
    External (_SB_.SCK1.CP23, DeviceObj)
    External (_SB_.SCK1.CP24, DeviceObj)
    External (_SB_.SCK1.CP25, DeviceObj)
    External (_SB_.SCK1.CP26, DeviceObj)
    External (_SB_.SCK1.CP27, DeviceObj)
    External (_SB_.SCK1.CP28, DeviceObj)
    External (_SB_.SCK1.CP29, DeviceObj)
    External (_SB_.SCK1.CP2A, DeviceObj)
    External (_SB_.SCK1.CP2B, DeviceObj)
    External (_SB_.SCK1.CP2C, DeviceObj)
    External (_SB_.SCK1.CP2D, DeviceObj)
    External (_SB_.SCK1.CP2E, DeviceObj)
    External (_SB_.SCK1.CP2F, DeviceObj)
    External (_SB_.SCK1.CP30, DeviceObj)
    External (_SB_.SCK1.CP31, DeviceObj)
    External (_SB_.SCK1.CP32, DeviceObj)
    External (_SB_.SCK1.CP33, DeviceObj)
    External (_SB_.SCK1.CP34, DeviceObj)
    External (_SB_.SCK1.CP35, DeviceObj)
    External (_SB_.SCK1.CP36, DeviceObj)
    External (_SB_.SCK1.CP37, DeviceObj)
    External (HWEN, UnknownObj)
    External (PETE, UnknownObj)
    External (PSEN, UnknownObj)
    External (PSLM, UnknownObj)
    External (SCKN, UnknownObj)

    Scope (\_SB.SCK0.CP00)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP00.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP00.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP00.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP00)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP00.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP00.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP00.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP01)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP01.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP01.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP01.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP01)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP01.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP01.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP01.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP02)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP02.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP02.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP02.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP02)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP02.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP02.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP02.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP03)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP03.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP03.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP03.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP03)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP03.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP03.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP03.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP04)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP04.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP04.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP04.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP04)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP04.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP04.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP04.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP05)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP05.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP05.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP05.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP05)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP05.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP05.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP05.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP06)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP06.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP06.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP06.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP06)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP06.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP06.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP06.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP07)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP07.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP07.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP07.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP07)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP07.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP07.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP07.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP08)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP08.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP08.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP08.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP08)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP08.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP08.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP08.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP09)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP09.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP09.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP09.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP09)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP09.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP09.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP09.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP0A)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP0A.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP0A.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP0A.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP0A)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP0A.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP0A.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP0A.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP0B)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP0B.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP0B.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP0B.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP0B)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP0B.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP0B.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP0B.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP0C)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP0C.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP0C.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP0C.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP0C)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP0C.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP0C.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP0C.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP0D)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP0D.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP0D.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP0D.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP0D)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP0D.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP0D.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP0D.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP0E)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP0E.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP0E.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP0E.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP0E)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP0E.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP0E.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP0E.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP0F)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP0F.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP0F.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP0F.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP0F)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP0F.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP0F.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP0F.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP10)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP10.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP10.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP10.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP10)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP10.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP10.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP10.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP11)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP11.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP11.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP11.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP11)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP11.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP11.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP11.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP12)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP12.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP12.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP12.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP12)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP12.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP12.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP12.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP13)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP13.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP13.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP13.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP13)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP13.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP13.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP13.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP14)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP14.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP14.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP14.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP14)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP14.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP14.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP14.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP15)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP15.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP15.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP15.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP15)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP15.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP15.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP15.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP16)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP16.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP16.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP16.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP16)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP16.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP16.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP16.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP17)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP17.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP17.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP17.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP17)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP17.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP17.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP17.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP18)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP18.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP18.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP18.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP18)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP18.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP18.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP18.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP19)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP19.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP19.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP19.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP19)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP19.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP19.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP19.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP1A)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP1A.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP1A.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP1A.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP1A)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP1A.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP1A.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP1A.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP1B)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP1B.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP1B.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP1B.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP1B)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP1B.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP1B.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP1B.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP1C)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP1C.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP1C.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP1C.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP1C)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP1C.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP1C.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP1C.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP1D)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP1D.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP1D.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP1D.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP1D)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP1D.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP1D.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP1D.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP1E)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP1E.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP1E.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP1E.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP1E)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP1E.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP1E.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP1E.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP1F)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP1F.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP1F.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP1F.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP1F)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP1F.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP1F.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP1F.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP20)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP20.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP20.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP20.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP20)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP20.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP20.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP20.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP21)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP21.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP21.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP21.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP21)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP21.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP21.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP21.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP22)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP22.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP22.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP22.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP22)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP22.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP22.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP22.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP23)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP23.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP23.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP23.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP23)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP23.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP23.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP23.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP24)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP24.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP24.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP24.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP24)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP24.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP24.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP24.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP25)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP25.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP25.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP25.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP25)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP25.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP25.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP25.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP26)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP26.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP26.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP26.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP26)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP26.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP26.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP26.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP27)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP27.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP27.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP27.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP27)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP27.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP27.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP27.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP28)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP28.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP28.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP28.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP28)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP28.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP28.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP28.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP29)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP29.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP29.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP29.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP29)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP29.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP29.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP29.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP2A)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP2A.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP2A.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP2A.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP2A)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP2A.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP2A.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP2A.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP2B)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP2B.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP2B.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP2B.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP2B)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP2B.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP2B.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP2B.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP2C)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP2C.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP2C.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP2C.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP2C)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP2C.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP2C.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP2C.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP2D)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP2D.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP2D.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP2D.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP2D)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP2D.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP2D.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP2D.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP2E)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP2E.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP2E.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP2E.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP2E)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP2E.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP2E.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP2E.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP2F)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP2F.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP2F.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP2F.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP2F)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP2F.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP2F.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP2F.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP30)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP30.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP30.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP30.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP30)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP30.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP30.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP30.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP31)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP31.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP31.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP31.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP31)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP31.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP31.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP31.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP32)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP32.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP32.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP32.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP32)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP32.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP32.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP32.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP33)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP33.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP33.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP33.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP33)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP33.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP33.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP33.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP34)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP34.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP34.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP34.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP34)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP34.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP34.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP34.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP35)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP35.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP35.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP35.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP35)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP35.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP35.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP35.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP36)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP36.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP36.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP36.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP36)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP36.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP36.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP36.ZPSS */
        }
    }

    Scope (\_SB.SCK0.CP37)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK0.CP37.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK0.CP37.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK0.CP37.ZPSS */
        }
    }

    Scope (\_SB.SCK1.CP37)
    {
        Name (NCPU, 0x80000000)
        Name (DOMN, 0x80000000)
        Method (_PPC, 0, NotSerialized)  // _PPC: Performance Present Capabilities
        {
            PETE |= 0x80
            Return (DerefOf (PSLM [SCKN]))
        }

        Name (NPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (FFixedHW, 
                    0x00,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000000, // Address
                    ,)
            }
        })
        Name (SPCT, Package (0x02)
        {
            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000880, // Address
                    ,)
            }, 

            ResourceTemplate ()
            {
                Register (SystemIO, 
                    0x10,               // Bit Width
                    0x00,               // Bit Offset
                    0x0000000000000882, // Address
                    ,)
            }
        })
        Method (_PCT, 0, NotSerialized)  // _PCT: Performance Control
        {
            Return (NPCT) /* \_SB_.SCK1.CP37.NPCT */
        }

        Name (ZPSS, Package (0x01)
        {
            Package (0x06)
            {
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00, 
                0x00
            }
        })
        Name (NPSS, Package (0x10)
        {
            Package (0x06)
            {
                0x000009C5, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00002700, 
                0x00002700
            }, 

            Package (0x06)
            {
                0x000009C4, 
                0x000249F0, 
                0x0000000A, 
                0x0000000A, 
                0x00001900, 
                0x00001900
            }, 

            Package (0x06)
            {
                0x00000960, 
                0x00022C1D, 
                0x0000000A, 
                0x0000000A, 
                0x00001800, 
                0x00001800
            }, 

            Package (0x06)
            {
                0x000008FC, 
                0x00020EDD, 
                0x0000000A, 
                0x0000000A, 
                0x00001700, 
                0x00001700
            }, 

            Package (0x06)
            {
                0x00000898, 
                0x0001F230, 
                0x0000000A, 
                0x0000000A, 
                0x00001600, 
                0x00001600
            }, 

            Package (0x06)
            {
                0x00000834, 
                0x0001D610, 
                0x0000000A, 
                0x0000000A, 
                0x00001500, 
                0x00001500
            }, 

            Package (0x06)
            {
                0x000007D0, 
                0x0001BA7D, 
                0x0000000A, 
                0x0000000A, 
                0x00001400, 
                0x00001400
            }, 

            Package (0x06)
            {
                0x0000076C, 
                0x00019F74, 
                0x0000000A, 
                0x0000000A, 
                0x00001300, 
                0x00001300
            }, 

            Package (0x06)
            {
                0x000006A4, 
                0x00016B07, 
                0x0000000A, 
                0x0000000A, 
                0x00001100, 
                0x00001100
            }, 

            Package (0x06)
            {
                0x00000640, 
                0x0001519F, 
                0x0000000A, 
                0x0000000A, 
                0x00001000, 
                0x00001000
            }, 

            Package (0x06)
            {
                0x000005DC, 
                0x000138BD, 
                0x0000000A, 
                0x0000000A, 
                0x00000F00, 
                0x00000F00
            }, 

            Package (0x06)
            {
                0x00000578, 
                0x00012063, 
                0x0000000A, 
                0x0000000A, 
                0x00000E00, 
                0x00000E00
            }, 

            Package (0x06)
            {
                0x00000514, 
                0x0001088B, 
                0x0000000A, 
                0x0000000A, 
                0x00000D00, 
                0x00000D00
            }, 

            Package (0x06)
            {
                0x000004B0, 
                0x0000F13B, 
                0x0000000A, 
                0x0000000A, 
                0x00000C00, 
                0x00000C00
            }, 

            Package (0x06)
            {
                0x0000044C, 
                0x0000DA6B, 
                0x0000000A, 
                0x0000000A, 
                0x00000B00, 
                0x00000B00
            }, 

            Package (0x06)
            {
                0x000003E8, 
                0x0000C420, 
                0x0000000A, 
                0x0000000A, 
                0x00000A00, 
                0x00000A00
            }
        })
        Method (_PSS, 0, NotSerialized)  // _PSS: Performance Supported States
        {
            If ((PSEN && (HWEN < 0x02)))
            {
                Return (NPSS) /* \_SB_.SCK1.CP37.NPSS */
            }

            Return (ZPSS) /* \_SB_.SCK1.CP37.ZPSS */
        }
    }
}

