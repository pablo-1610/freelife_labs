---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [animations] created at [28/07/2021 00:49]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@class Animations
Animations = {}

---fadeOut
---@param _src number
---@param smoothTime number
---@return nil
---@public
function Animations:fadeOut(smoothTime)
    DoScreenFadeOut(smoothTime)
    while not IsScreenFadedOut() do Wait(1) end
end

---fadeIn
---@param _src number
---@param smoothTime number
---@return nil
---@public
function Animations:fadeIn(smoothTime)
    DoScreenFadeIn(smoothTime)
    while not IsScreenFadedIn() do Wait(1) end
end

function Animations:drawTexts(x, y, text, center, scale, rgb, font, justify)
    SetTextFont(font)
    SetTextScale(scale, scale)

    SetTextColour(rgb[1], rgb[2], rgb[3], rgb[4])
    SetTextEntry("STRING")
    --SetTextJustification(justify)
    --SetTextRightJustify(justify)
    SetTextCentre(center)
    AddTextComponentString(text)
    EndTextCommandDisplayText(x,y)
end

local baseX = 0.085
local baseY = 0.10
local baseWidth = 0.15
local baseHeight = 0.03
function Animations:advancedDesc(title, color, components)
    DrawRect(baseX, baseY - 0.058, baseWidth, baseHeight - 0.025, color[1], color[2], color[3], 255)
    DrawRect(baseX, baseY - 0.043, baseWidth, baseHeight, 0, 0, 0, 170)
    Animations:drawTexts(baseX - 0.0395, baseY - (0.043) - 0.013, title, false, 0.35, {255, 255, 255, 255}, 2, 0)
    -- Desc
    --DrawRect(baseX, (baseY - 0.043) + 0.030, baseWidth, baseHeight, 0, 0, 0, 150)
    for k, v in pairs(components) do
        DrawRect(baseX, (baseY - 0.043) + (0.030*(k)), baseWidth, baseHeight, 0, 0, 0, 150)
        Animations:drawTexts(baseX - 0.073, baseY - (0.043) + (0.030*(k)) - 0.013, v[1], false, 0.35, {255, 255, 255, 255}, 4, 0)
    end
end

RegisterNetEvent("fl_lags:animTeleport")
AddEventHandler("fl_lags:animTeleport", function(pos)
    canInteractWithZone = false
    DoScreenFadeOut(2500)
    while not IsScreenFadedOut() do Wait(1) end
    SetEntityCoords(PlayerPedId(), pos.pos, false, false, false, false)
    SetEntityHealth(PlayerPedId(), pos.heading)
    Wait(100)
    DoScreenFadeIn(1500)
    while not IsScreenFadedIn() do Wait(1) end
    canInteractWithZone = true
end)

RegisterNetEvent("fl_lags:animTeleportt")
AddEventHandler("fl_lags:animTeleportt", function(x, y, z)
    canInteractWithZone = false
    DoScreenFadeOut(2500)
    while not IsScreenFadedOut() do Wait(1) end
    SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, false)
    Wait(100)
    DoScreenFadeIn(1500)
    while not IsScreenFadedIn() do Wait(1) end
    canInteractWithZone = true
end)
