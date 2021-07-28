---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Los Narcos.

  File [main] created at [21/05/2021 16:06]

  Copyright (c) Los Narcos - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local blips = {}
blips.list = {}

AddEventHandler("fl_labs:loaded", function()
    TriggerServerEvent("requestPredefinedBlips")
end)


RegisterNetEvent("newBlip")
---@param blip Blip
AddEventHandler("newBlip", function(blip)
    if blips.list[blip.blipId] ~= nil and DoesBlipExist(blips.list[blip.blipId]) then
        RemoveBlip(blips.list[blip.blipId])
    end
    blips.list[blip.blipId] = blip
    local b = AddBlipForCoord(blip.position)
    SetBlipSprite(b, blip.sprite)
    SetBlipColour(b, blip.color)
    SetBlipAsShortRange(b, false)
    SetBlipScale(b, blip.scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blip.text)
    EndTextCommandSetBlipName(b)
    blips.list[blip.blipId].blip = b
end)

RegisterNetEvent("delBlip")
AddEventHandler("delBlip", function(blipID)
    if blips.list[blipID] == nil then
        return
    end
    if blips.list[blipID].blip ~= nil and DoesBlipExist(blips.list[blipID].blip) then
        RemoveBlip(blips.list[blipID].blip)
    end
    blips.list[blipID] = nil
end)

RegisterNetEvent("cbBlips")
AddEventHandler("cbBlips", function(incomingBlips)
    blips.list = incomingBlips
    ---@param blip Blip
    for blipID, blip in pairs(incomingBlips) do
        local b = AddBlipForCoord(blip.position)
        SetBlipSprite(b, blip.sprite)
        SetBlipColour(b, blip.color)
        SetBlipAsShortRange(b, blip.shortRange)
        SetBlipScale(b, blip.scale)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blip.text)
        EndTextCommandSetBlipName(b)
        blips.list[blipID].blip = b
    end
end)