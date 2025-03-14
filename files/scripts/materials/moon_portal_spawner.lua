
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local tbl = EntityGetInRadiusWithTag( x, y, 400, "cast_share" ) or {}

if #tbl < 1 then
    local filepath = "mods/Apotheosis/files/entities/buildings/moon_portal.xml"
    local eid = EntityLoad( filepath, x, y - 20 )

    --Change portal graphics if it's the sun
    if HasFlagPersistent("moon_is_sun") then
        local comp = EntityGetFirstComponentIncludingDisabled(eid,"UIInfoComponent")
        ComponentSetValue2(comp,"name","$teleport_portal_sun")

        comp = EntityGetComponentIncludingDisabled(eid,"SpriteParticleEmitterComponent")
        ComponentSetValue2(comp[1],"sprite_file","mods/Apotheosis/files/particles/orangewhirl_$[1-8].png")
        ComponentSetValue2(comp[2],"sprite_file","data/particles/fire_falling.xml")
        ComponentSetValue2(comp[2],"randomize_rotation",0,0)
        ComponentSetValue2(comp[2],"randomize_angular_velocity",0,0)

        comp = EntityGetFirstComponentIncludingDisabled(eid,"ParticleEmitterComponent")
        ComponentSetValue2(comp,"emitted_material_name","spark")
        ComponentSetValue2(comp,"emission_interval_min_frames",1)
        ComponentSetValue2(comp,"emission_interval_max_frames",2)
        ComponentSetValue2(comp,"velocity_always_away_from_center",80)
        ComponentSetValue2(comp,"lifetime_max",2)

		comp = EntityAddComponent2(
			eid,
			"LuaComponent",
			{
                script_source_file="mods/Apotheosis/files/scripts/buildings/sun_portal_fire.lua",
                execute_every_n_frame=10,
			}
		)

		comp = EntityAddComponent2(
			eid,
			"MagicConvertMaterialComponent",
			{
				kill_when_finished=false,
                from_material_tag="[burnable]",
                steps_per_frame=20,
                to_material=CellFactory_GetType("fire"),
                is_circle=true,
                radius=120,
			}
		)
    end
end
    
EntityKill( entity_id )
