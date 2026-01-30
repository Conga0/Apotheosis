
function material_area_checker_success( pos_x, pos_y )
    local spritecomps = EntityGetComponentIncludingDisabled(GetUpdatedEntityID(), "SpriteComponent") or {}
    for k=1,#spritecomps do
        if ComponentGetValue2(spritecomps[k],"image_file") == "data/ui_gfx/gun_actions/colour_rainbow.png" then
            ComponentSetValue2(spritecomps[k],"image_file","mods/Apotheosis/files/ui_gfx/gun_actions/colour_rainbow_pastel.png")
            EntityRefreshSprite( GetUpdatedEntityID(), spritecomps[k] )

            local itemcomp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "ItemComponent")
            ComponentSetValue2(itemcomp,"ui_sprite","mods/Apotheosis/files/ui_gfx/gun_actions/colour_rainbow_pastel.png")
            ComponentSetValue2(itemcomp,"always_use_item_name_in_ui",true)
            ComponentSetValue2(itemcomp,"item_name",GameTextGet("$spell_apotheosis_rainbow_glimmer_pastel_name")) 

            EntityLoad("mods/Apotheosis/files/entities/particles/image_emitters/chest_effect_rainbow_gas.xml",pos_x,pos_y)
		    GamePlaySound( "data/audio/Desktop/materials.bank", "collision/glass_potion/destroy", pos_x, pos_y )
        end
    end
end
