local Inventory = require("scripts/inventory")

local function OnSlotsChanged(event)
    -- only if player changed it directly
    if event.player_index ~= nil then
        local enabled = settings.get_player_settings(event.player_index)["logistics_requests_sorted-enabled"].value
        if enabled then
            Inventory.SortEntityInventory(event.entity)
        end
    end
end

script.on_event(defines.events.on_entity_logistic_slot_changed, OnSlotsChanged)
