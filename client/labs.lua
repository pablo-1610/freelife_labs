---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [labs] created at [28/07/2021 01:36]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

inside, infos = false, {}

RegisterNetEvent("fl_labs:exitLab")
AddEventHandler("fl_labs:exitLab", function()
    inside = false
end)

local function calcContainerSize(container)
    local tot = 0
    for item, count in pairs(container.input) do
        tot = tot + count
    end
    for item, count in pairs(container.output) do
        tot = tot + count
    end
    return tot
end

local function calcSize(ctn)
    local tot = 0
    for k, v in pairs(ctn) do
        tot = (tot + v)
    end
    return tot;
end

RegisterNetEvent("fl_labs:updateLabInfos")
AddEventHandler("fl_labs:updateLabInfos", function(key, val)
    infos[key] = val
    if key == 2 then
        infos["containersize"] = calcSize(val.output)
    end
end)

--[[

info[1] = Type label
info[2] = Container
info[3] = Capacité
info[4] = Faction
info[5] = InProd
info["containersize"] = All container size

--]]
RegisterNetEvent("fl_labs:enterLab")
AddEventHandler("fl_labs:enterLab", function(labInfos)
    infos = labInfos
    infos["containersize"] = calcSize(infos[2].output)
    inside = true
    -- Title
    local LiseretColor = { 191, 66, 245 }
    local baseX = 0.085
    local baseY = 0.10
    local baseWidth = 0.15
    local baseHeight = 0.03
    while inside do
        Wait(0)
        Animations:advancedDesc(("Laboratoire de %s"):format(infos[1]), { 191, 66, 245 }, {
            { ("Type: %s"):format(infos[1]) },
            { ("Produits finis: %s/%s"):format(calcSize(infos[2].output), infos[3]) },
            { ("Production: %s"):format((infos[5] and "Active" or "Inactive")), infos[5] and { 85, 163, 59, 255 } or { 163, 59, 59, 255 } },
            { ("Faction: %s"):format(infos[4]) }
        })
    end
end)

RegisterNetEvent("fl_labs:translateContainer")
AddEventHandler("fl_labs:translateContainer", function(labType, container)
    if labType == 1 then
        local ipl = exports["bob74_ipl"]:GetBikerWeedFarmObject()
    end
end)

RegisterCommand("tt", function()
    local ipl = exports["bob74_ipl"]:GetBikerWeedFarmObject()

end)

local function updateIplWeed(size, BikerWeedFarm)
    if size >= 10 then
        BikerWeedFarm.Plant1.Set(BikerWeedFarm.Plant1.Stage.full, BikerWeedFarm.Plant1.Light.basic)
    end

    if size >= 20 then
        BikerWeedFarm.Plant2.Set(BikerWeedFarm.Plant2.Stage.full, BikerWeedFarm.Plant2.Light.basic)
    end

    if size >= 30 then
        BikerWeedFarm.Plant3.Set(BikerWeedFarm.Plant3.Stage.full, BikerWeedFarm.Plant3.Light.basic)
    end

    if size >= 40 then
        BikerWeedFarm.Plant4.Set(BikerWeedFarm.Plant4.Stage.full, BikerWeedFarm.Plant4.Light.basic)
    end

    if size >= 50 then
        BikerWeedFarm.Plant5.Set(BikerWeedFarm.Plant5.Stage.full, BikerWeedFarm.Plant5.Light.basic)
    end

    if size >= 60 then
        BikerWeedFarm.Plant6.Set(BikerWeedFarm.Plant6.Stage.full, BikerWeedFarm.Plant6.Light.basic)
    end

    if size >= 70 then
        BikerWeedFarm.Plant7.Set(BikerWeedFarm.Plant7.Stage.full, BikerWeedFarm.Plant7.Light.basic)
    end

    if size >= 80 then
        BikerWeedFarm.Plant8.Set(BikerWeedFarm.Plant8.Stage.full, BikerWeedFarm.Plant8.Light.basic)
    end

    if size >= 90 then
        BikerWeedFarm.Plant9.Set(BikerWeedFarm.Plant9.Stage.full, BikerWeedFarm.Plant9.Light.basic)
    end
    RefreshInterior(BikerWeedFarm.interiorId)
end

RegisterNetEvent("fl_labs:translateIplTable")
AddEventHandler("fl_labs:translateIplTable", function(iplTable, inContainer, type)
    if iplTable ~= nil then
        if iplTable.type == 1 then
            local ipl = exports["bob74_ipl"]:GetBikerWeedFarmObject()
            ipl.Plant1.Clear(true)
            ipl.Plant2.Clear(true)
            ipl.Plant3.Clear(true)
            ipl.Plant4.Clear(true)
            ipl.Plant5.Clear(true)
            ipl.Plant6.Clear(true)
            ipl.Plant7.Clear(true)
            ipl.Plant8.Clear(true)
            ipl.Plant9.Clear(true)
            ipl.Details.Enable({ "weed_set_up" }, true, true)
            ipl.Details.Enable({ "weed_drying" }, false)
            ipl.Style.Set("weed_upgrade_equip", false)
        end
    end
    if inContainer ~= nil then
        local size = calcSize(inContainer)
        if type == 1 then
            local BikerWeedFarm = exports["bob74_ipl"]:GetBikerWeedFarmObject()
            updateIplWeed(size, BikerWeedFarm)
        end
    end
end)

RegisterNetEvent("fl_labs:translateIplTableOutpt")
AddEventHandler("fl_labs:translateIplTableOutpt", function(table, type)
    if type == 1 then
        local BikerWeedFarm = exports["bob74_ipl"]:GetBikerWeedFarmObject()
        updateIplWeed(calcSize(table), BikerWeedFarm)
    end
end)