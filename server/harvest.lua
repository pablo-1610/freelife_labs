---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [harvest] created at [27/07/2021 13:26]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@class Haverst
Harvest = {}

---@type table<number, table>
Harvest.Current = {}

Citizen.CreateThread(function()
    while true do
        Wait(2500)
        for _src, infos in pairs(Harvest.Current) do
            local ped = GetPlayerPed(_src)
            if ped ~= nil then
                local pedPos = GetEntityCoords(ped)
                if #(infos[1] - pedPos) > 2.0 then
                    Harvest.Current[_src] = nil
                    Utils:notify(_src, "Vous êtes parti de la zone, récolte stoppée")
                else
                    local xPlayer = ESX.GetPlayerFromId(_src)
                    if xPlayer.getInventoryItem(infos[2]).count >= infos[3] then
                        Harvest.Current[_src] = nil
                        Utils:notify(_src, "Vous avez atteint le maximum d'objets de ce type dans votre inventaire !")
                    else
                        xPlayer.addInventoryItem(infos[2], 1)
                    end
                end
            end
        end
    end
end)

AddEventHandler("playerDropped", function()
    Harvest.Current[source] = nil
end)

---initialize
---@return nil
---@public
function Harvest:initialize()
    for _, infos in pairs(Drugs) do
        for _, componentsInfos in pairs(infos.farm_components) do
            Zones.createPublic(componentsInfos.harvest, 20, { r = 255, g = 255, b = 255, a = 130 }, function(_src)
                Harvest:haverst(_src, componentsInfos.harvest, { componentsInfos.item, componentsInfos.label, componentsInfos.max })
            end, ("Appuyez sur ~INPUT_CONTEXT~ pour ramasser: ~b~%s"):format(componentsInfos.label), 1.0, 1.0)
        end
    end
end

---haverst
---@param _src number
---@param position table
---@param itemInfos table
---@return nil
---@public
function Harvest:haverst(_src, position, itemInfos)
    Harvest.Current[_src] = { position, itemInfos[1], itemInfos[3] }
    Utils:notify(_src, ("Vous commencez à ramasser: ~b~%s"):format(itemInfos[2]))
end
