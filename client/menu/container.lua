---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [container] created at [29/07/2021 22:30]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local function counttable(table)
    local t = 0
    for k, v in pairs(table) do
        t = (t + 1)
    end
    return t
end

local function openMenu(id, requiered)
    if isMenuOpened then
        return
    end
    local cat, title, desc = "fllabs_1", "Laboratoires", "Laboratoires de drogues"
    FreezeEntityPosition(PlayerPedId(), true)
    isMenuOpened = true

    RMenu.Add(cat, sub(cat, "main"), RageUI.CreateMenu(title, desc, nil, nil, "menu", "black"))
    RMenu:Get(cat, sub(cat, "main")).Closed = function()
    end

    RMenu.Add(cat, sub(cat, "prod"), RageUI.CreateSubMenu(RMenu:Get(cat, sub(cat, "main")), nil, desc, nil, nil, "menu", "black"))
    RMenu:Get(cat, sub(cat, "prod")).Closed = function()
    end

    RMenu.Add(cat, sub(cat, "out"), RageUI.CreateSubMenu(RMenu:Get(cat, sub(cat, "main")), nil, desc, nil, nil, "menu", "black"))
    RMenu:Get(cat, sub(cat, "out")).Closed = function()
    end

    RageUI.Visible(RMenu:Get(cat, sub(cat, "main")), true)

    Citizen.CreateThread(function()
        while isMenuOpened do
            local shouldStayOpened = false
            RageUI.IsVisible(RMenu:Get(cat, sub(cat, "main")), true, true, true, function()
                shouldStayOpened = true
                RageUI.Separator(("~s~Capacité: ~b~%s~s~/~b~%s"):format(infos["containersize"], infos[3]))
                RageUI.ButtonWithStyle("Inventaire de production", "Appuyez pour accéder à l'inventaire de production", { RightLabel = "→" }, true, function(_, _, s)
                end, RMenu:Get(cat, sub(cat, "prod")))
                RageUI.ButtonWithStyle("Inventaire des produits finis", "Appuyez pour accéder à l'inventaire des produits finis", { RightLabel = "→" }, true, function(_, _, s)
                end, RMenu:Get(cat, sub(cat, "out")))
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get(cat, sub(cat, "prod")), true, true, true, function()
                shouldStayOpened = true
                RageUI.Separator(("~s~Capacité: ~b~%s~s~/~b~%s"):format(infos["containersize"], infos[3]))
                for itemID, value in pairs(requiered) do
                    RageUI.ButtonWithStyle(("~b~[x%i] ~s~%s"):format((infos[2].input[value[2]] == nil) and 0 or infos[2].input[value[2]], ItemsLabels[value[2]] or "Item inconnu"), ("Au minimum ~r~%s objet de ce type ~s~est requis pour fabriquer un produit finis !"):format(value[1]), { RightLabel = "~g~Ajouter ~s~→" }, (not isWaitingForServerUpdate), function(_, _, s)
                        if s then
                            local result = ClientUtils:showBox("Montant à déposer", "", 2, true)
                            if result ~= nil and tonumber(result) ~= nil and tonumber(result) > 0 then
                                isWaitingForServerUpdate = true
                                TriggerServerEvent("ft_labs:deposit", id, value[2], tonumber(result))
                            else
                                ESX.ShowNotification("~r~Montant invalide")
                            end
                        end
                    end)
                end
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get(cat, sub(cat, "out")), true, true, true, function()
                shouldStayOpened = true
                RageUI.Separator(("~s~Capacité: ~b~%s~s~/~b~%s"):format(infos["containersize"], infos[3]))
                local canWithdraw = false
                canWithdraw = (counttable(infos[2].output) > 0)
                RageUI.ButtonWithStyle("Récuperer les produits finis", "Vous permets de récuperer les produits finis", {}, (not isWaitingForServerUpdate and canWithdraw), function(_, _, s)
                    if s then
                        isWaitingForServerUpdate = true
                        TriggerServerEvent("ft_labs:withdraw", id)
                    end
                end)
                if (canWithdraw) then
                    RageUI.Separator("↓ ~b~Contenu ~s~↓")
                    for id, count in pairs(infos[2].output) do
                        RageUI.Button(("~b~[x%i] ~s~%s"):format(count, ItemsLabels[id] or "Item inconnu"), nil, true)
                    end
                end
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

RegisterNetEvent("fl_labs:openContainer")
AddEventHandler("fl_labs:openContainer", openMenu)