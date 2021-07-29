---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [utils] created at [27/07/2021 12:10]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@class Utils
Utils = {}

---getIdentifiers
---@param _src number
---@return table
---@public
function Utils:getIdentifiers(_src)
    local identifiers = {}
    local playerIdentifiers = GetPlayerIdentifiers(_src)
    for _, v in pairs(playerIdentifiers) do
        local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
        identifiers[before] = playerIdentifiers[_]
    end
    return identifiers
end

---notify
---@param _src number
---@param message string
---@return void
---@public
function Utils:notify(_src, message)
    TriggerClientEvent("esx:showNotification", _src, message)
end

---putInInstanceRange
---@param _src number
---@param range number
---@return void
---@public
function Utils:putInInstanceRange(_src, range)
    SetRoutingBucketPopulationEnabled((range+_src), false)
    SetPlayerRoutingBucket(_src, (range+_src))
end

---putInInstance
---@param _src number
---@param instance number
---@return void
---@public
function Utils:putInInstance(_src, instance)
    SetPlayerRoutingBucket(_src, instance)
end

---getPlayerInv
---@param _src number
---@return table
---@public
function Utils:getPlayerInv(_src)
    xPlayer = ESX.GetPlayerFromId(_src)
    return xPlayer.getInventory(true)
end

---setOnPublicInstance
---@param _src number
---@return void
---@public
function Utils:setOnPublicInstance(_src)
    SetPlayerRoutingBucket(_src, 0)
end

