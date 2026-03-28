--Check if the player is under the effects of Portalic Rideshare
function portaliumCheck(plyr_id, from_x, from_y, to_x, to_y)
    if GameGetGameEffectCount( plyr_id, "CUSTOM" ) > 0 then
        local comp = GameGetGameEffect( plyr_id, "CUSTOM" )
        if comp ~= 0 then
            if ComponentGetValue2( comp, "custom_effect_id") == "TELEPORT_RIDESHARE" then
                --Player is confirmed to have Portalic Rideshare
                local targets = EntityGetInRadiusWithTag(from_x, from_y, 128,"teleportable_NOT")
                for k=1,#targets
                do local v = targets[k]
                    if EntityHasTag(v,"player_unit") == false then
                        --Calculate target offset from player
                        local x,y = EntityGetTransform(v)
                        local target_x, target_y = (to_x + (x - from_x))
                        local target_y = (to_y + (y - from_y))

                        local did_hit, r_x, r_y = Raytrace(to_x,to_y,target_x,target_y)
                        if did_hit then
                            --Move all creatures over to the new location if a solid wall was in the way
                            EntitySetTransform(v,r_x, r_y)
                        else
                            --Move all creatures over to the new location if it's open air
                            EntitySetTransform(v,target_x, target_y)
                        end
                    end
                end
            end
        end
    end
end

function manaInfiniteCheck(player_id)
    local children = EntityGetAllChildren(player_id) or {}
    for k=1,#children do
        if EntityGetName(children[k]) == "apotheosis_curse_of_mana" then
            local vsc_comp = EntityGetFirstComponentIncludingDisabled(children[k],"VariableStorageComponent")
            ComponentSetValue2(vsc_comp,"value_bool",true)
            break
        end
    end
end

--Check if Heretic or his portal is nearby, if so then turn the stone to rapid mode
function hereticCheck(player_id, from_x, from_y, to_x, to_y)
    local red_alert = false
    local heretic_found = false
    local h_x, h_y = nil
    local boss = EntityGetInRadiusWithTag( from_x, from_y, 350, "miniboss" ) or {}
    for bp=1,#boss do
        if EntityGetName(boss[bp]) == "$enemy_apotheosis_boss_flesh_monster" then
            heretic_found = true
            h_x,h_y = EntityGetTransform(boss[bp])
            break
        end
    end

    if heretic_found == true then
        local dist_x = h_x - to_x
        local dist_y = h_y - to_y
        local distance = math.sqrt( dist_x ^ 2 + dist_y ^ 2 )
        if distance >= 600 then
            red_alert = true
        end
    end

    if red_alert == true then
        local heretic_stones = EntityGetInRadiusWithTag(from_x,from_y,48,"apoth_perk_forgable")
        for k=1,#heretic_stones do
            local v = heretic_stones[k]
            local comp = EntityGetFirstComponentIncludingDisabled(v,"PhysicsImageShapeComponent")
            if ComponentGetValue2(comp,"image_file") == "mods/Apotheosis/files/items_gfx/goldnugget_01_alt_heretic.png" and EntityGetParent(v) ~= 0 then
                local timercomp = EntityGetFirstComponentIncludingDisabled( v, "VariableStorageComponent" )
                ComponentSetValue2( timercomp, "value_string", "rapid")
                break
            end
        end
    end
end