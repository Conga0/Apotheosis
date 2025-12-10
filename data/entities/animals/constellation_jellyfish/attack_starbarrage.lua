local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform(entity_id)
local vsc_comps = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local generic_ai_data = vsc_comps[1]
local star_barrage_data = vsc_comps[2]
--[[
local portal_timer = ComponentGetValue2(star_barrage_data,"value_float")
portal_timer = portal_timer + 1.0
ComponentSetValue2(star_barrage_data,"value_float",portal_timer)
]]--

local attack_cd = 600
local star_count = 12
local time_between_stars = 15

local frame = GameGetFrameNum()
local last_attack = ComponentGetValue2(star_barrage_data,"value_int")

for k=1,star_count do
    if frame == last_attack + ((k) * time_between_stars) then
        SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )
        local x_offset = Random(-20,20)
        local y_offset = Random(-20,20)

        local pid = EntityLoad("mods/Apotheosis/files/entities/projectiles/star_shot_jellyfish.xml",pos_x,pos_y)
        GameShootProjectile( entity_id, pos_x, pos_y, pos_x + x_offset, pos_y + y_offset, pid)
    end
end

if frame > last_attack + attack_cd then
    SetRandomSeed(pos_x,pos_y)
    ComponentSetValue2(star_barrage_data,"value_int",frame + Random(0,60))
    
    --[[
    if portal_timer > 2 then
        ComponentSetValue2(star_barrage_data,"value_float",0.0)
        if Random(1,3) == 1 then
            local targets = EntityGetInRadiusWithTag(pos_x,pos_y,256,"mortal") or {}
            for k=1,#targets do
                local v = targets[k]
                if EntityHasTag(v,"miniboss") == false then
                    local targ_x, targ_y = EntityGetTransform(v)
                    --Play audio when sapping shields
                    GamePlaySound( "data/audio/Desktop/projectiles.bank", "player_projectiles/megalaser/launch", pos_x, pos_y )
                    GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/mana_fully_recharged", pos_x, pos_y )

                    local pid = EntityLoad("mods/Apotheosis/files/entities/projectiles/jellyfish_portal_aggressive.xml",pos_x,pos_y)
                    GameShootProjectile( entity_id, pos_x, pos_y, targ_x, targ_y, pid)
                end
            end
        end
    end
    ]]--
end