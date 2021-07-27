---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [UpgradeType] created at [27/07/2021 12:37]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

UpgradeTypes = {
    STYLE = 1,
    SECURITY = 2,
}

UpgradeTypeLabels = {
    [UpgradeTypes.STYLE] = "Style",
    [UpgradeTypes.SECURITY] = "Sécurité"
}

UpgradeTable = {
    [UpgradeTypes.SECURITY] = function(table)
        return table.Security
    end,

    [UpgradeTypes.STYLE] = function(table)
        return table.Style
    end
}