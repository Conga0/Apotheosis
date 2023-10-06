

function shot( proj_id )
    local entity_id = GetUpdatedEntityID()
    local filepath = GlobalsGetValue( "apotheosis_bat_filepath", "data/entities/animals/bat.xml" )
    if filepath ~= "data/entities/animals/bat.xml" then
        local comp = EntityGetFirstComponentIncludingDisabled(proj_id, "ProjectileComponent")
        ComponentSetValue2(comp,"spawn_entity",filepath)
    end

    local gfx = GlobalsGetValue( "apotheosis_batgfx_filepath", "data/enemies_gfx/bat.xml" )

    EntityAddComponent2(
        proj_id,
        "SpriteComponent",
        {
            image_file=gfx,
            offset_x=8,
            offset_y=14,
            rect_animation="walk"
        }
    )
end
