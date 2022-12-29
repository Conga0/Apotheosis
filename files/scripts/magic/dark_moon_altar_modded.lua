dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Apotheosis/files/scripts/magic/creature_shift_file.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local test = get_flag_name( "u_dheglmticg" )

local essence_1 = GameHasFlagRun( "essence_fire" )
local essence_2 = GameHasFlagRun( "essence_air" )
local essence_3 = GameHasFlagRun( "essence_water" )
local essence_4 = GameHasFlagRun( "essence_laser" )

local essence_6 = GameHasFlagRun( "apotheosis_essence_fungus" )

local players = EntityGetWithTag( "player_unit" )
local players_ = EntityGetWithTag( test )
local sun = EntityGetInRadiusWithTag( x, y, 56, "seed_e" )
local sun2 = EntityGetInRadiusWithTag( x, y, 56, "seed_f" )

function moon_shift()
	SetRandomSeed(x + GameGetFrameNum(), y)

	-- spawn random eye particles
	if ( rand(0,1) > 0.5 ) then
		function spawn( x,y )
			EntityLoad( "data/entities/particles/treble_eye.xml", x,y )
		end
	
		local x,y = x + rand(-100,100), y + rand(-80,80)
		local rad = rand(0,30)
	
		spawn(x,y)
		spawn( x + 40 + rad, y + 30 + rad )
		spawn( x - 40 - rad, y + 30 + rad )
	end
	
	-- shift creatures
	creature_shift( entity_id, x, y, true )
end

if essence_6 and ( #players_ == 0 ) and ( #sun == 0 ) and ( #sun2 == 0 ) then
	local do_effect = false
	
	if ( #players > 0 ) then
		for i,player_id in ipairs(players) do
			local px, py = EntityGetTransform( player_id )
			local dist = math.abs( x - px ) + math.abs( y - py )
			
			if ( dist < 48 ) then
				do_effect = true
			end
		end
	end
	
	if do_effect then
        --GamePrint(" MOON TEST ")
		--EntityLoad("data/entities/items/orbs/orb_13.xml", x, y)
		--AddFlagPersistent( "card_unlocked_destruction" )
		--local eid = CreateItemActionEntity( "DESTRUCTION", x, y )
		
		if essence_6 then
			EntityLoad("mods/Apotheosis/files/scripts/essence/moon_effect_redstone.xml", x, y)
			GamePrintImportant( "$log_apotheosis_moon_altar_fungus", "$logdesc_apotheosis_moon_altar_fungus" )
            moon_shift()
            local player_id = EntityGetWithTag( "player_unit" )
            player_id = player_id[1]
			local cid = EntityLoad("mods/Apotheosis/files/entities/misc/essence/moon_creature_curse.xml", x, y)
            EntityAddChild( player_id, cid )
		end

        -- Spawn Statue ------------------------------------------------------

        if (ModIsEnabled("nightmare") or ModIsEnabled("purgatory")) and HasFlagPersistent( "apotheosis_moon_fungus_unlock_goldmode" ) == false then
            EntityLoad( "mods/Apotheosis/files/entities/props/goldmode/statue_essence_fungus_moon.xml", 4461, 2049 )
            AddFlagPersistent( "apotheosis_moon_fungus_unlock_goldmode" )
        elseif HasFlagPersistent( "apotheosis_moon_fungus_unlock" ) == false then
            EntityLoad( "mods/Apotheosis/files/entities/props/statue_essence_fungus_moon.xml", 4461, 2049 )
			AddFlagPersistent( "apotheosis_moon_fungus_unlock" )
        end
		
		EntityKill( entity_id )
	end
end