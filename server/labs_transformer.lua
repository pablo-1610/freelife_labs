---@author Pablo Z.
---@version 1.0
--[[
  This file is part of FreeLife.
  
  File [labs_transformer] created at [29/07/2021 23:49]

  Copyright (c) FreeLife - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---@class LabsTransformer
LabsTransformer = {}

---getAllLabsFromType
---@return nil
---@public
function LabsTransformer:getAllLabsFromType(type)
    local labs = {}
    ---@param lab Lab
    for id, lab in pairs(Labs.list) do
        if lab.type == type then
            labs[id] = lab
        end
    end
    return labs
end

---getRewardsCount
---@param rewardTable table
---@return number
---@public
function LabsTransformer:getRewardsCount(rewardTable)
    local tot = 0
    for k, v in pairs(rewardTable) do
        tot = (tot + v[1])
    end
    return tot
end

---getRewards
---@param rewardTable table
---@return table
---@public
function LabsTransformer:getRewards(rewardTable)
    local items = {}
    for k, v in pairs(rewardTable) do
        items[v[2]] = v[1]
    end
    return items
end

---haveIngredients
---@param current table
---@param requiered table
---@return boolean
---@public
function LabsTransformer:haveIngredients(current, requiered)
    local requiredComponents, matching = #requiered, 0

    for _, values in pairs(requiered) do
        local count, item = values[1], values[2]
        local have = (current[item] ~= nil and current[item] >= count)
        if have then
            matching = (matching + 1)
        end
    end
    return (matching >= requiredComponents)
end

function LabsTransformer:getContainerSize(container)
    local tot = 0
    for k, v in pairs(container) do
        tot = (tot + v)
    end
    return tot
end

---init
---@return nil
---@public
function LabsTransformer:init()
    for type, data in pairs(Drugs) do
        Citizen.CreateThread(function()
            while true do
                local labs = LabsTransformer:getAllLabsFromType(type)
                local rewardCount = LabsTransformer:getRewardsCount(Drugs[type].production.prod_out)
                local reward = Drugs[type].production.prod_out
                local requiered = Drugs[type].production.prod_in
                local maxCapacity = Drugs[type].lab.outcapacity

                for id, lab in pairs(labs) do
                    -- Can ?
                    local canTransform = true

                    --if (lab:getFullContainerSize() + rewardCount) > maxCapacity then canTransform = false end
                    if (LabsTransformer:getContainerSize(lab.container.output) + rewardCount > maxCapacity) then
                        canTransform = false
                    end

                    if (not LabsTransformer:haveIngredients(lab.container.input, requiered)) then
                        canTransform = false
                    end

                    if canTransform then
                        local container = lab.container.input
                        -- Farm in
                        for _, values in pairs(requiered) do
                            local count, item = values[1], values[2]
                            local fakeFinalQty = (container[item] - count)
                            if (fakeFinalQty <= 0) then
                                fakeFinalQty = nil
                            end
                            lab.container.input[item] = fakeFinalQty;
                        end
                        -- Prod out
                        for _, values in pairs(reward) do
                            local count, item = values[1], values[2];
                            if not lab.container.output[item] then
                                lab.container.output[item] = 0
                            end
                            lab.container.output[item] = (lab.container.output[item] + count)
                        end
                        lab.working = true
                        lab:saveInventory()
                        lab:updatePlayers()
                    else
                        if lab.working then
                            lab.working = false
                            lab:updatePlayers()
                        end
                    end
                end
                Wait(data.production.interval)
            end
        end)
    end
end