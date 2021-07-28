---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [interaction] created at [28/07/2021 00:05]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]



local function openMenu(id)
    if isMenuOpened then
        return
    end
    local cat, title, desc = "fllabs_1", "Laboratoires", "Laboratoires de drogues"
    FreezeEntityPosition(PlayerPedId(), true)
    isMenuOpened = true

    RMenu.Add(cat, sub(cat, "main"), RageUI.CreateMenu(title, desc, nil, nil, "menu", "black"))
    RMenu:Get(cat, sub(cat, "main")).Closed = function()
    end

    RageUI.Visible(RMenu:Get(cat, sub(cat, "main")), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            local shouldStayOpened = false
            RageUI.IsVisible(RMenu:Get(cat, sub(cat, "main")), true, true, true, function()
                shouldStayOpened = true
                RageUI.ButtonWithStyle("Entrer dans le laboratoire", "Appuyez pour entrer dans le laboratoire", {RightLabel = "→"}, true, function(_,_,s)
                    if s then
                        shouldStayOpened = false
                        canInteractWithZone = false
                        TriggerServerEvent("ft_labs:enterLab", id)
                    end
                end)
            end, function()
            end)

            if not shouldStayOpened and isMenuOpened then
                isMenuOpened = false
            end
            Wait(0)
        end
        FreezeEntityPosition(PlayerPedId(), false)
    end)
end

RegisterNetEvent("fl_labs:openItr")
AddEventHandler("fl_labs:openItr", openMenu)