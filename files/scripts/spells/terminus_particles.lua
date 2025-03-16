
dofile_once("mods/Apotheosis/lib/apotheosis/apotheosis_utils.lua")
local EZWand = dofile_once("mods/Apotheosis/lib/EZWand/EZWand.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local wand = EZWand(EntityGetParent(entity_id))
local x, y = EntityGetTransform(entity_id)
local frame = GameGetFrameNum()

if wand.mana > 9999 then
    EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_script", true )
    SetRandomSeed(frame+x,x+y)
    if Random(1,5) == 1 then
        local rng = Random(1,3)
        GamePlaySound( "data/audio/Desktop/explosions.bank", "explosion_electric_0" .. rng, x, y )
    end
else
    EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_script", false )
end
