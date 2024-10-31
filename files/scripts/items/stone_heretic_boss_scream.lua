local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

if not GameHasFlagRun("apotheosis_miniboss_boss_flesh_monster") then

local heretic_found = false

local boss = EntityGetInRadiusWithTag( pos_x, pos_y, 450, "miniboss" ) or nil
for bp=1,#boss do
    if EntityGetName(boss[bp]) == "$creep_apotheosis_boss_flesh_monster_name" then
	--Mmmyes making every potential Heretic in the area make the sound will be funny
	heretic_found = true
	h_x, h_y = EntityGetTransform( boss[bp] )
	GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/monster", h_x, h_y );
	GameScreenshake( 150 )
    end
end

if heretic_found == false then
    GamePlaySound( "mods/Apotheosis/mocreeps_audio.bank", "mocreeps_audio/items/stone_heretic/monster_distant", pos_x, pos_y );
    GameScreenshake( 100 )
end

end

EntityKill( entity_id )