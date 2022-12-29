dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()

local comp = EntityGetFirstComponent( entity_id, "AnimalAIComponent" )
local x,y = EntityGetTransform( entity_id )

SetRandomSeed(x, y * GameGetFrameNum())

if ModIsEnabled("new_enemies") then
    state = Random( 0, 21 ) --Time orb from new enemies is not included as it isn't enabled in theirs either, they couldn't get it working without a specific setup if I had to guess?
else
    state = Random( 0, 18 )
end

if (state == 1) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/orb_duck.xml" )
elseif (state == 2) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/orb_berserk.xml" )
    --ComponentSetValue2( comp, "tries_to_ranged_attack_friends", false )
elseif (state == 3) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/orb_ambrosia.xml" )
    --ComponentSetValue2( comp, "tries_to_ranged_attack_friends", true )
elseif (state == 4) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_cursed.xml" )
elseif (state == 5) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_dark.xml" )
elseif (state == 6) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_hearty.xml" )
elseif (state == 7) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_homing.xml" )
elseif (state == 8) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_neutral.xml" )
elseif (state == 9) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/orb_unstable_transmutation.xml" ) -- If you think of anything new then feel free to replace this with whatever
elseif (state == 10) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_swapper.xml" )
elseif (state == 11) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_tele.xml" )
elseif (state == 12) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_twitchy.xml" )
elseif (state == 13) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_weaken.xml" )
elseif (state == 14) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_wither.xml" )
elseif (state == 15) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/orb_explosive.xml" )
elseif (state == 16) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/orb_manadrain.xml" )
elseif (state == 17) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/orb_unstable_transmutation.xml" )
elseif (state == 18) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "mods/Apotheosis/files/entities/projectiles/orb_psychotic.xml" ) --End for vanilla & mo creeps orbs, everything fromhere one needs modded dependencies.
elseif (state == 19) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_earthquake.xml" )
elseif (state == 20) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_trip.xml" )
elseif (state == 21) then
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/orb_toxic.xml" )
else
    ComponentSetValue2( comp, "attack_ranged_entity_file", "data/entities/projectiles/iceball.xml" )
end