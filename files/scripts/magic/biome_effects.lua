function biome_entered( new_biome_name, old_biome_name )
	-- print( "new_biome_name: " .. new_biome_name )
	local entity_id = GetUpdatedEntityID()
    local player = EntityGetParent(entity_id)
    local underwater = ( new_biome_name == "$biome_underwater" )
    local plane_yggdrasil = ( new_biome_name == "$biome_plane_yggdrasil" ) or ( new_biome_name == "$biome_plane_yggdrasil_border" )
    local plane_magic = ( new_biome_name == "$biome_plane_magic" )
    local plane_technology = ( new_biome_name == "$biome_plane_technology" )
    --local empyrean = ( new_biome_name == "$biome_empyrean" )

    function loadCurse(player_id,filepath)
        if not player_id then return end
        local children = EntityGetAllChildren(player_id) or {}
        for k=1,#children do
            local v = children[k]
            if EntityHasTag(v,"curse") then
                return
            end
        end
        local pos_x, pos_y = EntityGetTransform(player_id)
        local child = EntityLoad(filepath, pos_x, pos_y)
        EntityAddChild(player_id,child)
    end

	if underwater then
        loadCurse(player,"mods/apotheosis/files/entities/misc/curse_weaken.xml")
    elseif plane_yggdrasil then
        loadCurse(player,"mods/apotheosis/files/entities/misc/curse_yggdrasil.xml")
    elseif plane_magic then
        loadCurse(player,"mods/apotheosis/files/entities/misc/curse_magic.xml")
    elseif plane_technology then
        loadCurse(player,"mods/apotheosis/files/entities/misc/curse_technology.xml")
    --elseif empyrean then
    --    loadCurse(player,"mods/apotheosis/files/entities/misc/curse_empyrean.xml")
	else
        local children = EntityGetAllChildren(player) or {}
        for k=1,#children do
            local v = children[k]
            if EntityHasTag(v,"curse") then
                local comp = EntityGetFirstComponentIncludingDisabled(v,"LifetimeComponent")
                ComponentSetValue2(comp,"lifetime",3)
                break
            end
        end
	end
end

--Conga: Could make this more scalable in the future with a table if needed
--This could also be useful for the planes biomes, makes things a lot easier