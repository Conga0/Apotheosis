dofile_once("data/scripts/lib/utilities.lua")
dofile_once( "data/scripts/gun/gun_actions.lua" )

function make_random_card( x, y )
	-- this does NOT call SetRandomSeed() on purpouse. 
	-- SetRandomSeed( x, y )

	local item = ""
	local valid = false

	while ( valid == false ) do
		local itemno = math.random( 1, #actions )
		local thisitem = actions[itemno]
		item = string.lower(thisitem.id)
		
		if ( thisitem.spawn_requires_flag ~= nil ) then
			local flag_name = thisitem.spawn_requires_flag
			local flag_status = HasFlagPersistent( flag_name )
			
			if flag_status then
				valid = true
			end

			-- 
			if( thisitem.spawn_probability == "0" ) then 
				valid = false
			end
			
		else
			valid = true
		end
	end


	if ( string.len(item) > 0 ) then
		local card_entity = CreateItemActionEntity( item, x, y )
		return card_entity
	else
		print( "No valid action entity found!" )
	end
end

function release_curse()
	local entity_id = GetUpdatedEntityID()
	local pos_x,pos_y = EntityGetTransform(entity_id)
    
    --Called if the chest is broken before the curse is removed
    EntityLoad( "data/entities/particles/particle_explosion/main_swirly_red.xml", pos_, pos_y )
	GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/greed_curse/create", pos_x, pos_y )
    GameAddFlagRun("apotheosis_chest_coffer_openned")
end

function item_pickup( entity_item, entity_who_picked, name )
	local entity_id = GetUpdatedEntityID()
	local pos_x,pos_y = EntityGetTransform(entity_id)

    --Coffers can be openned as something obtained before the endgame (sacreligious) but after the earlygame (mainpath), as an alternate way to power level during the mid-game.
    --Maybe reward sigils?
    --RED_SIGIL grants +30 damage
    --GREEN_SIGIL grants a status effect which triples incoming healing
    --Chromatic Sigil converts all of a spell's damage into a specific damage type, right click to rotate the damage type, projectile gets a -90% contribution penalty, explosive -50%, holy gets a 50% recievement penalty but a 50% contribution bonus
    --BLUE_SIGIL grants +60 mana
    --What if using sigils directly contributed to your phantom curse?
    --Casting any sigil spell grants 0.1% phantom curse
    local sigil_spells = {"RED","BLUE","GREEN","CHROMATIC"}


    --Flair
    EntityLoad( "data/entities/particles/particle_explosion/main_swirly_red.xml", pos_, pos_y )
    GamePlaySound( "data/audio/Desktop/misc.bank", "misc/chest_dark_open", pos_x, pos_y )
    GameAddFlagRun("apotheosis_chest_coffer_openned")

    EntityKill( entity_item )

end

function physics_body_modified( is_destroyed )
	local entity_id = GetUpdatedEntityID()
    if EntityHasTag(entity_id,"apotheosis_cursed_item") == true then
        release_curse()
    else
        item_pickup(entity_id)
    end
end