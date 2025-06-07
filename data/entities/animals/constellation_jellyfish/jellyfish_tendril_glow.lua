local this_lua = GetUpdatedComponentID()
    
local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity(entity_id)

local verlet_component = EntityGetFirstComponentIncludingDisabled(entity_id, "VerletPhysicsComponent")
local positions = ComponentGetValue2(verlet_component, "positions")

local aicomp = EntityGetFirstComponentIncludingDisabled(parent_id,"VariableStorageComponent")
local aggressive = ComponentGetValue2(aicomp,"value_bool")

-- Iterate over the positions table with a step of 2
for i = 1, #positions, 2 do
    local pos_x = positions[i]       -- x coordinate
    local pos_y = positions[i + 1]   -- y coordinate

    -- Create rainbow particles at each position
    --GameCreateCosmeticParticle( "rainbow_gas", pos_x, pos_y, 1, 0, 0, 0, 5.0, 10.0, true, true, false, true, 0, 0 )
    --GameCreateParticle( "rainbow_gas", pos_x, pos_y, 1, 5, 5, true, false, true )
    if EntityHasTag(parent_id,"minion") == false then
        EntityLoad("mods/Apotheosis/files/entities/animators/rainbow_particle.xml",pos_x,pos_y)
    end

    local targets = EntityGetInRadiusWithTag( pos_x, pos_y, 20, "player_unit" ) or {}
    for k=1,#targets do
        local children = EntityGetAllChildren(targets[k]) or {}
        local found = false
        for l=1,#children do
            if EntityGetName(children[l]) == "constellation_jellyfish_teleport" then
                found = true
                local vscomp = EntityGetFirstComponentIncludingDisabled(children[l],"VariableStorageComponent")
                ComponentSetValue2(vscomp,"value_float",0.05 + ComponentGetValue2(vscomp,"value_float"))
                break
            end
        end
        if found == false then
            --If the jellyfish isn't in a combat state & the player is nearby, then transport them to the tomb containing a celestial pearl
            if aggressive == false then
                local child = EntityLoad("data/entities/animals/constellation_jellyfish/jellyfish_teleport_peaceful.xml")
                EntityAddChild(targets[k],child)
            --If in combat then hurt or teleport the target away to a dangerous area
            else
                local child = EntityLoad("data/entities/animals/constellation_jellyfish/jellyfish_teleport_aggressive.xml")
                EntityAddChild(targets[k],child)
            end
        end
    end
end
