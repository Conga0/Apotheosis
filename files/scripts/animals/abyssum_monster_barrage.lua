
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local cooldown_frames = 660
local current_frame = GameGetFrameNum()

local cooldown_frame
local variablecomp = EntityGetComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
for k=1,#variablecomp
do local v = variablecomp[k]
    if ComponentGetValue2(v,"name") == "meteor_cooldown" then
        variablecomp = v
        break
    end
end
cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )

local players = EntityGetWithTag( "player_unit" )
local player = players[1]
if player == nil then return end
local plyr_x, plyr_y = EntityGetTransform(player)

if current_frame >= (cooldown_frame - 60) then
    GameShootProjectile(entity_id,x,y,plyr_x,plyr_y,EntityLoad("mods/apotheosis/files/entities/projectiles/meteor_white.xml", x, y))
    if current_frame >= cooldown_frame then
        ComponentSetValue2( variablecomp, "value_int", current_frame + cooldown_frames + math.random(-60,60) )
    end
end


--(local did_hit = RaytraceSurfaces(pos_x, pos_y, plyr_x, plyr_y)
