--if player picks up the stone, then activate the other script and disable this one to begin the pursuit
--also turns on particles and whatnot
--probably not needed, but uhh... better safe than sorry?
--what are you talking about past me? what is better safe than sorry? is it the item_pickup function you're referring to?
function item_pickup( entity_item, entity_who_picked, item_name )
    local entity_id = GetUpdatedEntityID()
    --GameAddFlagRun("apotheosis_flesh_boss_released")
    --If someone kicks the stone all the way to Squidward's orb room, then more power to them
    if not GameHasFlagRun("apotheosis_flesh_boss_stone_initiated") then
	local targets = EntityGetWithTag( "pitcheck_b" )
	for k=1,#targets
	do local v = targets[k]
	    EntitySetComponentsWithTagEnabled( v, "disabled", true )
	end
    end
    GameAddFlagRun("apotheosis_flesh_boss_stone_initiated")
    GameRemoveFlagRun("apotheosis_flesh_boss_stone_destroyed")
    GameRemoveFlagRun("apotheosis_flesh_boss_stone_converted")

    EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_liquid", true)

    local timercomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
    ComponentSetValue2( timercomp, "value_float", 0)
    ComponentSetValue2( timercomp, "value_int", 0)

    if not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") then
	GamePrint("$log_apotheosis_flesh_boss_warning")
	GameTriggerMusicFadeOutAndDequeueAll(1)

	local heretic_found = false

	local boss = EntityGetWithTag( "miniboss" ) or nil
	for bp=1,#boss do
	    if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_flesh_monster_name" then
		--Mmmyes making every potential Heretic in the area make the sound will be funny I'm sure
		heretic_found = true
		h_x, h_y = EntityGetTransform( boss[bp] )
		GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/monster", h_x, h_y );
		GameScreenshake( 150 )
	    end
	end

	if heretic_found == false then
	    local child_id = EntityLoad( "mods/Apotheosis/files/entities/misc/stone_heretic_boss_scream.xml", x, y )
	    EntityAddChild( entity_who_picked, child_id )
	end
    end

    local comp_id = GetUpdatedComponentID()
    --EntitySetComponentIsEnabled(entity_id,comp_id,false)
    EntityRemoveComponent(entity_id,comp_id)
end