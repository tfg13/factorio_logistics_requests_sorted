local Inventory = require("scripts/inventory")

local function SyncButton(player)
    player.set_shortcut_toggled("logistics_requests_sorted-enabled", global.sorting_enabled[player.index])
end

local function ApplySorting(player, entity)
    if global.sorting_enabled[player.index] then
        Inventory.SortEntityInventory(entity)
    end
end


-- player management
local function InitPlayer(player)
    global.sorting_enabled[player.index] = true
    SyncButton(player)
    -- apply to main inventory right away
    ApplySorting(player, player.character)
end

local function DelPlayer(player_index)
    global.sorting_enabled[player_index] = nil
end

local function OnConfigurationChanged()
    if global.sorting_enabled == nil then
        global.sorting_enabled = {}
    end
    -- enable if not configured yet
    for index, player in pairs(game.players) do
        if global.sorting_enabled[player.index] == nil then
            InitPlayer(player)
        end
    end
end


-- runtime management
local function OnSlotsChanged(event)
    -- only if player changed it directly
    if event.player_index ~= nil then
        ApplySorting(game.get_player(event.player_index), event.entity)
    end
end

local function OnShortcut(player_index)
    local player = game.get_player(player_index)
    global.sorting_enabled[player.index] = not global.sorting_enabled[player.index]
    SyncButton(player)
    -- apply to main inventory right away
    ApplySorting(player, player.character)
end

local function OnLuaShortcut(event)
    -- only compute our own event
    if event.prototype_name ~= "logistics_requests_sorted-enabled" then
        return
    end
    OnShortcut(event.player_index)
end


script.on_init(OnConfigurationChanged)
script.on_configuration_changed(OnConfigurationChanged)
script.on_event(defines.events.on_player_created, function(event) InitPlayer(game.get_player(event.player_index)) end)
script.on_event(defines.events.on_player_removed, function(event) DelPlayer(event.player_index) end)
script.on_event(defines.events.on_entity_logistic_slot_changed, OnSlotsChanged)
script.on_event(defines.events.on_lua_shortcut, OnLuaShortcut)
script.on_event("logistics_requests_sorted-hotkey", function(event) OnShortcut(event.player_index) end)