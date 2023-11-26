local Inventory = {}

Inventory.SortEntityInventory = function(entity)
    if entity == nil then
        return
    end
    
    --record request items into inventory, counts into counts
    local inventory = game.create_inventory(entity.request_slot_count)
    local counts = {}

    --record and remove all old requests
    for i = 1, entity.request_slot_count do
        local oldValue = Inventory.GetSlot(entity, i)
        if oldValue.name ~= nil then
            inventory.insert({name=oldValue.name})
            counts[oldValue.name] = oldValue
        end
        Inventory.ClearSlot(entity, i)
    end

    inventory.sort_and_merge()

    --put them back, now in sorted order
    local slotIndex = 0
    for i = 1,#inventory - inventory.count_empty_stacks() do
        local invitem = inventory[i]
        slotIndex = slotIndex + 1
        Inventory.SetSlot(entity, slotIndex, {name = invitem.name, min = counts[invitem.name].min, max = counts[invitem.name].max})
    end

    --cleanup
    inventory.destroy()
end

-- helpers to abstract between player and vehicles with logistic slots
Inventory.GetSlot = function(entity, index)
    if entity.type == "character" then
        return entity.get_personal_logistic_slot(index)
    else
        return entity.get_vehicle_logistic_slot(index)
    end
end

Inventory.ClearSlot = function(entity, index)
    if entity.type == "character" then
        entity.clear_personal_logistic_slot(index)
    else
        entity.clear_vehicle_logistic_slot(index)
    end
end

Inventory.SetSlot = function(entity, index, val)
    if entity.type == "character" then
        entity.set_personal_logistic_slot(index, val)
    else
        entity.set_vehicle_logistic_slot(index, val)
    end
end

return Inventory
