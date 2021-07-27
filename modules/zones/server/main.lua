---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [main] created at [27/07/2021 12:57]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Zones = {}
Zones.list = {}

Zones.createPublic = function(location, type, color, onInteract, helpText, drawDist, itrDist)
    local zone = Zone(location, type, color, onInteract, helpText, drawDist, itrDist, false)
    local marker = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
    TriggerClientEvent("newMarker", -1, marker)
    return zone.zoneID
end

Zones.createPrivate = function(location, type, color, onInteract, helpText, drawDist, itrDist, baseAllowed)
    local zone = Zone(location, type, color, onInteract, helpText, drawDist, itrDist, true, baseAllowed)
    local marker = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
    local players = ESX.GetPlayers()
    for i = 1, #players, 1 do
        local kk = players[i]
        if zone:isAllowed(kk) then
            TriggerClientEvent("newMarker", kk, marker)
        end
    end
    return zone.zoneID
end

Zones.addAllowed = function(zoneID, playerId)
    if not Zones.list[zoneID] then
        return
    end
    ---@type Zone
    local zone = Zones.list[zoneID]
    if zone:isAllowed(playerId) then
        return
    end
    zone:addAllowed(playerId)
    local marker = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
    TriggerClientEvent("newMarker", playerId, marker)
    Zones.list[zoneID] = zone
end

Zones.removeAllowed = function(zoneID, playerId)
    if not Zones.list[zoneID] then
        return
    end
    ---@type Zone
    local zone = Zones.list[zoneID]
    if not zone:isAllowed(playerId) then
        return
    end
    zone:removeAllowed(playerId)
    TriggerClientEvent("delMarker", playerId, zoneID)
    Zones.list[zoneID] = zone
end

Zones.updatePrivacy = function(zoneID, newPrivacy)
    if not Zones.list[zoneID] then
        return
    end
    ---@type Zone
    local zone = Zones.list[zoneID]
    local wereAllowed = {}
    local wasRestricted = zone:isRestricted()
    if zone:isRestricted() then
        wereAllowed = zone.allowed
    end
    zone.allowed = {}
    zone:setRestriction(newPrivacy)
    if zone:isRestricted() then
        local players = ESX.GetPlayers()
        if not wasRestricted then
            for i=1, #xPlayers, 1 do
                local kk = xPlayers[i]
                local isAllowedtoSee = false
                for _, allowed in pairs(wereAllowed) do
                    if allowed == kk then
                        isAllowedtoSee = true
                    end
                end
                if not isAllowedtoSee then
                    TriggerClientEvent("delMarker", kk, zone.zoneID)
                end
            end
        end
    else
        if wasRestricted then
            for d, playerId in pairs(players) do
                local isAllowedtoSee = false
                for _, allowed in pairs(wereAllowed) do
                    if allowed == d then
                        isAllowedtoSee = true
                    end
                end
                if isAllowedtoSee then
                    local marker = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
                    TriggerClientEvent("newMarker", d, marker)
                end
            end
        end
    end
    Zones.list[zoneID] = zone
end

Zones.delete = function(zoneID)
    if not Zones.list[zoneID] then
        return
    end
    ---@type Zone
    local zone = Zones.list[zoneID]
    if zone:isRestricted() then
        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers, 1 do
            local uniqueId = xPlayers[i]
            if zone:isAllowed(uniqueId) then
                TriggerClientEvent("delMarker", uniqueId, zoneID)
            end
        end
    else
        TriggerClientEvent("delMarker", -1, zoneID)
    end
end

Zones.updateOne = function(source)
    local markers = {}
    ---@param zone Zone
    for zoneID, zone in pairs(Zones.list) do
        if zone:isRestricted() then
            if zone:isAllowed(source) then
                markers[zoneID] = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
            end
        else
            markers[zoneID] = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
        end
    end
    TriggerClientEvent("cbZones", source, markers)
end

RegisterNetEvent("requestPredefinedZones")
AddEventHandler("requestPredefinedZones", function()
    local source = source
    Zones.updateOne(source)
end)

RegisterNetEvent("interactWithZone")
AddEventHandler("interactWithZone", function(zoneID)
    local source = source
    if not Zones.list[zoneID] then
        DropPLayer(source, "Tentative d'intéragir avec une zone inéxistante.")
        return
    end
    ---@type Zone
    local zone = Zones.list[zoneID]
    zone:interact(source)
end)