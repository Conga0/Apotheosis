
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

if math.random(1,3) == 1 then
    for k=1,3 do
        SetRandomSeed(pos_x + k,pos_y)
        list = {"slime_teleporter","devourer","watermage","whisp"}
        rnd = Random(-80,80)
        rnd2 = Random(1,#list)
        EntityLoad(table.concat({"mods/apotheosis/files/entities/misc/debuff_portals/portal_",list[rnd2],".xml"}), pos_x + rnd, pos_y + rnd)
        --RO teleport sound
    end
end