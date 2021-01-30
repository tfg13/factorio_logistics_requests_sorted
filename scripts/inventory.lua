local Inventory = {}

Inventory.SortPlayerInventory = function(player)
    if player.character == nil or (not player.character.valid) then
        return
    end

    --record request items into inventory, counts into counts
    local inventory = game.create_inventory(player.character.request_slot_count)
    local counts = {}

    --record and remove all old requests
    for i = 1, player.character.request_slot_count do
        local oldValue = player.get_personal_logistic_slot(i)
        if oldValue.name ~= nil then
            inventory.insert({name=oldValue.name})
            counts[oldValue.name] = oldValue
        end
        player.clear_personal_logistic_slot(i)
    end

    inventory.sort_and_merge()

    --put them back, now in sorted order
    local slotIndex = 0
    for i = 1,#inventory - inventory.count_empty_stacks() do
        local invitem = inventory[i]
        slotIndex = slotIndex + 1
        player.set_personal_logistic_slot(slotIndex, {name = invitem.name, min = counts[invitem.name].min, max = counts[invitem.name].max})
    end

    --cleanup
    inventory.destroy()
end

return Inventory
