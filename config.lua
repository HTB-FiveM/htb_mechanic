Config = {}
Config.Debug = true

-- Set the identifier type as a string here, for example:
--		steam
--		ip
--		discord
--		license (Rockstar License)
--		license2 (Stray Rockstar License which I've seen appear, not sure why but allowing it here if it means anything to anyone)
--		xbl
--		live
Config.PlayerIdentifierType = 'license' -- Very easy to switch your identifier type for your platform

-- By default ESX only uses the value of the identifer (after the : symbol) in the users table.
-- FiveM required
Config.ExcludeIdentifierPrefix = false

-- Set the RP framework, supported values are:
--      none
--      esx
--      custom
Config.RolePlayFramework = 'none'

Config.UsingEsxLegacy = false


-----------------------------------------
Config.Mechanics = {
    Mech1 = {
        Name = "Mechanic 1",
        Blip = {
            -- Map Blip Details
            Location = vector3(-205.644, -1311.772, 31.268),
            Sprite = 446, -- radar_bennys
            Colour = 46, -- Gold
            Scale = 1.5
        },
        Zones = {
            BossActions = {
                Location = vector3(-210.928, -1331.723, 29.890),
                Marker = {
                    Type = 1,
                    Colour = {
                        r = 0, g = 0, b = 200, a = 255
                    },
                    Size = { x = 3.0, y = 3.0, z = 1.0 }
                },
                ActionText = 'Press ~INPUT_PICKUP~ for boss menu'
            },
            CloakRoom = {
                Location = vector3(-206.577, -1326.375, 29.890),
                Marker = {
                    Type = 1,
                    Colour = {
                        r = 0, g = 200, b = 200, a = 255
                    },
                    Size = { x = 3.0, y = 3.0, z = 1.0 }
                },
                ActionText = 'Press ~INPUT_PICKUP~ to change clothes'
            },
            Service = {
                Location = vector3(-210.802, -1325.039, 29.890),
                Marker = {
                    Type = 1,
                    Colour = {
                        r = 0, g = 200, b = 0, a = 255
                    },
                    Size = { x = 3.0, y = 3.0, z = 1.0 }
                },
                ActionText = 'Press ~INPUT_PICKUP~ to modify vehicle'
            },
            Workbench = {
                Location = vector3(-201.059, -1318.449, 30.089),
                Marker = {
                    Type = 1,
                    Colour = {
                        r = 200, g = 0, b = 0, a = 255
                    },
                    Size = { x = 3.0, y = 3.0, z = 1.0 }
                },
                ActionText = 'Press ~INPUT_PICKUP~ to craft items'

            }
        }
    }
    
}


