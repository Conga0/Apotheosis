
local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform( entity_id )

local target = EntityGetClosestWithTag(x,y,"enemy")

local c = EntityLoad("mods/apotheosis/files/entities/misc/pylon/pylon_buff_protection_proj.xml")
local comp = EntityGetFirstComponentIncludingDisabled(c,"VariableStorageComponent")
ComponentSetValue2(comp,"value_int",entity_id)

EntityAddChild(target,c)

--Particle Effects at Pylon's location
EntityLoad("mods/apotheosis/files/entities/particles/circle_fast_green.xml", x, y - 10)
local targ_x,targ_y = EntityGetTransform(target)

--Particle Effects at Target's location
EntityLoad("mods/apotheosis/files/entities/particles/circle_fast_green.xml", targ_x, targ_y)
GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/all_seeing_eye/create", targ_x, targ_y);

local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
ComponentSetValue2(comp,"value_int",target)