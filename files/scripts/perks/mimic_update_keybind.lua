
dofile_once("mods/Apotheosis/lib/Apotheosis/apotheosis_utils.lua")
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local root = EntityGetRootEntity(entity_id)
local cooldown_frames = 30
local cooldown_frame
local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
local current_frame = GameGetFrameNum()

cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )
if current_frame >= cooldown_frame then
    if isButtonDown("disguise") then
        if EntityHasTag(root,"polymorphed_player") then
            local comp = EntityGetFirstComponentIncludingDisabled(root,"GameEffectComponent")
            ComponentSetValue2(comp,"frames",1)
        elseif EntityHasTag(root,"player_unit") then
            LoadGameEffectEntityTo( root, "mods/Apotheosis/files/entities/misc/effect_polymorph_mimic_statue.xml" )
            ComponentSetValue2( variablecomp, "value_int", current_frame + cooldown_frames )
        end
    end
end

if current_frame % 20 == 0 then
    
end