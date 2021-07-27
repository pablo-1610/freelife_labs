---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [factions] created at [27/07/2021 23:24]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@type table<?>
Factions = {}

AddEventHandler("fl_labs:loaded", function()
    MySQL.Async.fetchAll("SELECT * FROM factions", {}, function(result)
        for k, v in pairs(result) do
            table.insert(Factions, v.name)
        end
    end)
end)

---exists
---@param faction string
---@return boolean
---@public
function Factions:exists(faction)
    for k, v in pairs(Factions) do
        if v:lower() == faction:lower() then
            return true
        end
    end
    return false
end