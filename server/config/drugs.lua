---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [drugs] created at [27/07/2021 12:29]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@class Config
Config = {
    instancesRanges = 75800
}

---@class Drugs
Drugs = {
    [DrugType.WEED] = {
        bobIplGetter = "GetBikerWeedFarmObject",

        farm_components = {
            --{item = "beer", label = "Bière", max = 50, harvest = vector3(2873.1667, 4601.2075, 48.0166)},
            --{item = "pepsi", label = "Pepsi", max = 10, harvest = vector3(-623.8909, 1464.9534, 308.8686)},
        },

        lab = {
            price = 150,

            upgrades = {
                [UpgradeTypes.STYLE] = {
                    [1] = {label = "Style basique", price = 150, set = "weed_standard_equip", default = 1},
                    [2] = {label = "Style basique", price = 300, set = "weed_upgrade_equip"},
                },

                [UpgradeTypes.SECURITY] = {
                    [1] = {label = "Sécurité faible", price = 150, set = "weed_low_security", default = 1},
                    [2] = {label = "Haute sécurité", price = 150, set = "weed_security_upgrade"}
                }
            },

            iplDefaultFlags = {
                [FlagTypes.PLANT1] = 0,
                [FlagTypes.PLANT2] = 0,
                [FlagTypes.PLANT3] = 0,
                [FlagTypes.PLANT4] = 0,
                [FlagTypes.PLANT5] = 0,
                [FlagTypes.PLANT6] = 0,
                [FlagTypes.PLANT7] = 0,
                [FlagTypes.PLANT8] = 0,
                [FlagTypes.PLANT9] = 0,
            },

            positions = {
                inDoor = {pos = vector3(1062.11, -3186.45, -39.09), heading = 182.58},
                exit = {pos = vector3(1066.03, -3183.44, -39.16), heading = 94.8},
            };

            -- Additional things
            onEnter = function(lab)

            end
        },
    },

}