---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [main] created at [27/07/2021 12:09]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX, canInteractWithZone, isMenuOpened = nil, true, false

Citizen.CreateThread(function()
    TriggerEvent("esx:getSharedObject", function(obj)
        ESX = obj
        TriggerEvent("fl_labs:loaded")
    end)
end)