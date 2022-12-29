dofile_once( "data/scripts/lib/coroutines.lua" )
dofile_once( "data/scripts/lib/utilities.lua" )

local orbcount = GameGetOrbCountThisRun()
local entity = GetUpdatedEntityID()

if (orbcount >= 11) then

    local hpcomp = EntityGetFirstComponent( entity, "DamageModelComponent" )
    if( hpcomp ~= nil ) then
        ComponentSetValue( hpcomp, "max_hp", 20000 )
        ComponentSetValue( hpcomp, "hp", 20000 )
    end
	
	EntityAddComponent( eid, "CellEaterComponent", 
	{ 
		radius="40",
		eat_probability="100",
	} )
	
	EntityAddComponent( eid, "LuaComponent",
	{ 
		script_source_file="data/entities/animals/boss_musical_ghost/boss_musical_summon_healers.lua",
		execute_every_n_frame="1800",
        execute_times="10",
	} )

end