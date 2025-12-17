-- Migration for version 0.2.2
-- Initializes the PlatformHubs cache for performance optimization

-- Initialize PlatformHubs storage if it doesn't exist
storage.PlatformHubs = storage.PlatformHubs or {}

-- Skip if Space Age mod is not active
if not script.active_mods["space-age"] then return end

-- Populate the cache by scanning all surfaces for space-platform-hub entities
for _, surface in pairs(game.surfaces) do
    local platform_hubs = surface.find_entities_filtered{
        name = "space-platform-hub"
    }
    if #platform_hubs > 0 then
        storage.PlatformHubs[surface.name] = platform_hubs
    end
end

-- Clean up empty surface entries in PlatformWarehouses to fix memory leak
for surface_name, warehouses in pairs(storage.PlatformWarehouses or {}) do
    if #warehouses == 0 then
        storage.PlatformWarehouses[surface_name] = nil
    end
end
