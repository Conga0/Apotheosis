function biome_entered( new_biome_name, old_biome_name )
	-- print( "new_biome_name: " .. new_biome_name )
	local entity_id = GetUpdatedEntityID()
    local player = EntityGetParent(entity_id)

	if( new_biome_name == "$biome_underwater" ) then
        local pos_x, pos_y = EntityGetTransform(player)
        local child = EntityLoad("mods/apotheosis/files/entities/misc/curse_weaken.xml", pos_x, pos_y)
        EntityAddChild(player,child)
	else
        local children = EntityGetAllChildren(player)
        for k=1,#children do
            local v = children[k]
            if EntityGetName(v) == "apotheosis_curse_weaken" then
                local comp = EntityGetFirstComponentIncludingDisabled(v,"LifetimeComponent")
                ComponentSetValue2(comp,"lifetime",3)
                break
            end
        end
	end
end

--Conga: Could make this more scalable in the future with a table if needed
--This could also be useful for the planes biomes, makes things a lot easier