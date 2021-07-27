---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [Lab] created at [27/07/2021 12:27]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@class Lab

---@field public id number
---@field public type number
---@field public faction string
---@field public entry table<x:number, y:number, z:number>
---@field public upgrades table
---@field public flags table
---@field public container table

---@field public zone Zone
---@field public exitZone Zone
---@field public inside table

Lab = {}
Lab.__index = Lab

setmetatable(Lab, {
    __call = function(_, decode, data)
        local self = setmetatable({}, Lab);
        local get = function(data)
            return data
        end
        if decode then
            get = function(data)
                return json.decode(data)
            end
        end

        -- Def public
        self.id = data.id
        self.type = data.type
        self.faction = data.faction
        self.entry = get(data.entry)
        self.upgrades = get(data.upgrades)
        self.flags = get(data.flags)
        self.container = get(data.container)

        -- Def protected
        self.inside = {}
        self.zone = Zones.createPublic(vector3(self.entry.x, self.entry.y, self.entry.z), 20, { r = 255, g = 255, b = 255, a = 130 }, function(_src) self:interact(_src) end, "Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec le laboratoire", 1.0, 1.0)
        self.exitZone = Zones.createPrivate(Drugs[self.type].lab.positions.exit, 20, { r = 255, g = 79, b = 79, a = 130 }, function(_src) self:exit(_src) end, "Appuyez sur ~INPUT_CONTEXT~ pour sortir du laboratoire", 1.0, 1.0)
        return self;
    end
})

---addInside
---@param _src number
---@return nil
---@public
function Lab:addInside(_src)
    self.inside[_src] = GetPlayerPed(_src)
end

---removeFromInside
---@param _src number
---@return nil
---@public
function Lab:removeFromInside(_src)
    self.inside[_src] = nil
end

---isInside
---@param _src number
---@return boolean
---@public
function Lab:isInside(_src)
    return (self.inside[_src] ~= nil)
end

---enter
---@param _src number
---@return nil
---@public
function Lab:enter(_src)
    -- TODO -> Security check (is good faction ?)
    if self:isInside(_src) then
        return
    end
    self:addInside(_src)
    self.exitZone:addAllowed(_src)
    Utils:putInInstanceRange(_src, Config.instancesRanges)
end

function Lab:exit(_src)
    if not self:isInside(_src) then
        return
    end
    self.exitZone:removeAllowed(_src)
    self:removeFromInside(_src)
    Utils:setOnPublicInstance(_src)
end

---interact
---@param _src number
---@return nil
---@public
function Lab:interact(_src)
    local xPlayer = ESX.GetPlayerFromId(_src)
end
