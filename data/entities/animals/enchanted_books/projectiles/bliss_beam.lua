dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local proj_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"ProjectileComponent")
local shooter = ComponentGetValue2(proj_comp,"mWhoShot")
local shooter_animalAiComp = EntityGetFirstComponentIncludingDisabled(shooter,"AnimalAIComponent")
local current_target = ComponentGetValue2(shooter_animalAiComp,"mGreatestPrey") or ComponentGetValue2(shooter_animalAiComp,"mGreatestThreat") or EntityGetInRadiusWithTag( pos_x, pos_y, 350, "player_unit" )[1] or 0

local targ_x,targ_y = EntityGetTransform(current_target)

local did_hit, r_x, r_y = Raytrace(pos_x,pos_y,targ_x,targ_y)
if did_hit then
    --Hit terrain, do not apply debuff
    draw_line(pos_x,pos_y,r_x,r_y,"spark_red")
else
    --Hit target, apply debuff
    local c = EntityLoad("mods/Apotheosis/files/entities/misc/effect_hide_max_health.xml",pos_x,pos_y)
    EntityAddChild(current_target,c)
    draw_line(pos_x,pos_y,targ_x,targ_y,"spark_red")
end

EntityKill(entity_id)