---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [main] created at [27/07/2021 13:07]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local zones = {}
zones.cooldown = false
zones.list = {}

AddEventHandler("fl_labs:loaded", function()
    TriggerServerEvent("requestPredefinedZones")
    while true do
        local interval = 500
        local pos = GetEntityCoords(PlayerPedId())
        local closeToMarker = false
        for zoneId, zone in pairs(zones.list) do
            local zoneCoords = zone.position
            local dist = #(pos - zoneCoords)
            if dist <= zone.distances[1] and not isMenuOpened and canInteractWithZone then
                closeToMarker = true
                DrawMarker(zone.type, zoneCoords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, zone.color.r, zone.color.g, zone.color.b, zone.color.a, 0, 1, 2, 0, nil, nil, 0)
                if dist <= zone.distances[2] then
                    AddTextEntry("ZONES", (zone.help or "Appuyez sur ~INPUT_CONTEXT~ pour intéragir"))
                    DisplayHelpTextThisFrame("ZONES", false)
                    if IsControlJustPressed(0, 51) then
                        if not zones.cooldown then
                            zones.cooldown = true
                            TriggerServerEvent("interactWithZone", zone.id)
                            Citizen.SetTimeout(450, function()
                                zones.cooldown = false
                            end)
                        end
                    end
                end
            end
        end
        if closeToMarker then
            interval = 0
        end
        Wait(interval)
    end
end)

RegisterNetEvent("newMarker")
AddEventHandler("newMarker", function(zone)
    zones.list[zone.id] = zone
end)

RegisterNetEvent("delMarker")
AddEventHandler("delMarker", function(zoneID)
    zones.list[zoneID] = nil
end)

RegisterNetEvent("cbZones")
AddEventHandler("cbZones", function(zoneInfos)
    zones.list = zoneInfos
end)