-- Set up self
local this = {
    id = GetUpdatedEntityID(),
    x = nil,
    y = nil
}
this.x, this.y = EntityGetTransform(this.id)

-- Set up victims
local victim_max = 3
local victims = {}
for i=1, victim_max do
    victims[#victims+1] = {
        id = nil,
        distance = math.huge
    }
end

-- Locate victims
local enemies = EntityGetWithTag("enemy") or {}
for i = 1, #enemies do
    -- Build enemy table
    local enemy = {
        id = enemies[i],
        x = nil,
        y = nil,
        distance = nil
    }
    -- Check if self
    if enemy ~= this.id then
        -- Set enemy table data
        enemy.x, enemy.y = EntityGetTransform(enemy.id)
        enemy.distance = (this.x-enemy.x)^2 + (this.y-enemy.y)^2
        -- Iterate over victims, smallest to largest
        for j=1, #victims do
            -- If enemy distance is lesser:
            if victims[j].distance > enemy.distance then
                -- Insert enemy before the target (smallest to largest)
                table.insert(victims, j, {
                    id = enemy.id,
                    distance = enemy.distance
                })
                -- Delete 4th index, which the old 3rd closest has been pushed to
                victims[4] = nil
                break
            end
        end
    end
end

if #victims > 0 then
    for k=1,#victims
    do target = victims[k].id
        local c = EntityLoad("mods/Apotheosis/files/entities/misc/pylon/pylon_buff_hex_water.xml")
        local comp = EntityGetFirstComponentIncludingDisabled(c,"VariableStorageComponent")
        ComponentSetValue2(comp,"value_int",this.id)
        
        EntityAddChild(target,c)
        
        --Particle Effects at Pylon's location
        EntityLoad("mods/Apotheosis/files/entities/particles/circle_fast_blue.xml", this.x, this.y - 10)
        local targ_x,targ_y = EntityGetTransform(target)
        
        --Particle Effects at Target's location
        EntityLoad("mods/Apotheosis/files/entities/particles/circle_fast_blue.xml", targ_x, targ_y)
        GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye/create", targ_x, targ_y);
        
        local comp = EntityGetFirstComponentIncludingDisabled(this.id,"VariableStorageComponent")
        ComponentSetValue2(comp,"value_int",target)
    end
end
