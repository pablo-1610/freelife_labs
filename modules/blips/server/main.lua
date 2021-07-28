---@author Pablo Z.
---@version 1.0
--[[
  This file is part of Los Narcos.

  File [main] created at [21/05/2021 16:06]

  Copyright (c) Los Narcos - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Blips = {}
Blips.list = {}

Blips.createPublic = function(position, sprite, color, scale, text, shortRange)
    local blip = Blip(position, sprite, color, scale, text, shortRange, false)
    TriggerClientEvent("newBlip", -1, blip)
    return blip.blipId
end

Blips.createPrivate = function(position, sprite, color, scale, text, shortRange, baseAllowed)
    local blip = Blip(position, sprite, color, scale, text, shortRange, true, baseAllowed)
    local players = ESX.GetPlayers()
    for i = 1, #players, 1 do
        local kk = players[i]
        if blip:isAllowed(kk) then
            TriggerClientEvent("newBlip", kk, blip)
        end
    end
    return blip.blipId
end

Blips.addAllowed = function(blipID, playerId)
    if not Blips.list[blipID] then
        return
    end
    ---@type Blip
    local blip = Blips.list[blipID]
    if blip:isAllowed(playerId) then
        return
    end
    blip:addAllowed(playerId)
    TriggerClientEvent("newBlip", playerId, blip)
    Blips.list[blipID] = blip
end

Blips.removeAllowed = function(blipID, playerId)
    if not Blips.list[blipID] then
        return
    end
    ---@type Blip
    local blip = Blips.list[blipID]
    if not blip:isAllowed(playerId) then
        return
    end
    blip:removeAllowed(playerId)
    TriggerClientEvent("delBlip", playerId, blipID)
    Blips.list[blipID] = blip
end

Blips.updateOne = function(source)
    local blips = {}
    ---@param blip Blip
    for blipID, blip in pairs(Blips.list) do
        if blip:isRestricted() then
            if blip:isAllowed(source) then
                blips[blipID] = blip
            end
        else
            blips[blipID] = blip
        end
    end
    TriggerClientEvent("cbBlips", source, blips)
end

RegisterNetEvent("requestPredefinedBlips")
AddEventHandler("requestPredefinedBlips", function()
    local source = source
    Blips.updateOne(source)
end)