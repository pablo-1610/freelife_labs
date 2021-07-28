---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [labs] created at [28/07/2021 01:36]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local inside, infos = false, {}


RegisterNetEvent("fl_labs:exitLab")
AddEventHandler("fl_labs:exitLab", function()
    inside = false
end)

RegisterNetEvent("fl_labs:enterLab")
AddEventHandler("fl_labs:enterLab", function(labInfos)
    infos = labInfos
    inside = true
    -- Title
    local LiseretColor = {191, 66, 245}
    local baseX = 0.085
    local baseY = 0.10
    local baseWidth = 0.15
    local baseHeight = 0.03
    while inside do
        Wait(0)
        Animations:advancedDesc(("Laboratoire de %s"):format(labInfos[1]), {191, 66, 245}, {
            {("Inventaire: %s/%s"):format(labInfos[2], labInfos[3])},
            {("Faction: %s"):format(labInfos[4])}
        })
    end
end)