function generate_letter_sequence(comp)
    SetRandomSeed(123,456)
    local spellbook_letters = "abcdefghijklmnopqrstuvwxyz"
    local new_order = ""
    for k=1,#spellbook_letters do
        local rng = Random(1,#spellbook_letters)
        local letter = spellbook_letters:sub(rng, rng)
        new_order = new_order .. letter
        spellbook_letters = spellbook_letters:gsub(letter,"")
    end

    ComponentSetValue2(comp,"value_string",new_order)
    ComponentSetValue2(comp,"value_int",1)
end

function interacting( player_id, shrine_id, interactable_name )
    local entity_id = GetUpdatedEntityID()
    local pos_x,pos_y = EntityGetTransform(entity_id)
    local books = EntityGetInRadiusWithTag(pos_x,pos_y,70,"paper_book") or {}
    local vsccomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
    local letter_num = ComponentGetValue2(vsccomp,"value_int")
    if letter_num == -1 then 
        generate_letter_sequence(vsccomp)
        letter_num = 1
    end
    local letter_order = ComponentGetValue2(vsccomp,"value_string")
    local letters_to_create = 10

    for k=1,#books do
        local v = books[k]
        if EntityGetRootEntity(v) ~= v then
            for z=1,letters_to_create do
                if letter_num > #letter_order then letter_num = 1 end
                local letter = letter_order:sub(letter_num, letter_num)
                letter_num = letter_num + 1
                local spell_id = CreateItemActionEntity( "APOTHEOSIS_SPELLBOOK", pos_x, pos_y - 10 )
                local svcomp = EntityGetFirstComponentIncludingDisabled(spell_id,"VelocityComponent")

                local circle = math.pi * 2
                local inc = circle / (letters_to_create * 2 -2)
                local angle = inc * (z-1)

                local radius = 96
                local vel_x = math.cos( angle ) * radius
                local vel_y = 0 - math.sin( angle ) * radius

                GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/rune/create", pos_x, pos_y )
                SetRandomSeed((z+k * 30) + GameGetFrameNum(),(z+k * 30) + GameGetFrameNum())
                
                ComponentSetValue2(svcomp, "mVelocity", vel_x * Randomf(0.75^(k-1),1.00), vel_y * Randomf(0.80,1.20))
                ComponentSetValue2(svcomp, "gravity_y", 40)
                
                local spell_id = CreateItemActionEntity( "APOTHEOSIS_SPELLBOOK", pos_x, pos_y - 10 )
                ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(spell_id , "VariableStorageComponent"), "value_string", letter)

                --Return gravity to normal after the spell is picked up
                EntityAddComponent2(
                    spell_id,
                    "LuaComponent",
                    {
                        _enabled=true,
                        execute_on_added = false,
                        script_item_picked_up="mods/Apotheosis/files/scripts/special/terminus_spell_pickup.lua",
                        execute_every_n_frame = -1,
                        remove_after_executed = true,
                        execute_times=1
                    }
                )

            end
            EntityLoad("mods/Apotheosis/files/entities/particles/poof_green_dense.xml",pos_x,pos_y)
            EntityKill(v)
        end
    end
    ComponentSetValue2(vsccomp,"value_int",letter_num)
end

local entity_id = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform(entity_id)
local book_found = false
local pearl_found = false
local nearby_books = EntityGetInRadiusWithTag(pos_x,pos_y,128,"paper_book") or {}
local pearls = EntityGetInRadiusWithTag(pos_x,pos_y,70,"forgeable") or {}
for k=1,#nearby_books do
    if EntityGetRootEntity(nearby_books[k]) ~= nearby_books[k] then
        book_found = true
    elseif #pearls > 0 then
        for l=1,#pearls do
            if EntityGetName(pearls[l]) == "celestial_pearl" and EntityGetRootEntity(pearls[l]) == pearls[l] then
                pearl_found = true
            end
        end
    end
end

if book_found == true then
    EntitySetComponentsWithTagEnabled( entity_id,"enabled_by_script",true )
else
    EntitySetComponentsWithTagEnabled( entity_id,"enabled_by_script",false )
end

if pearl_found == true then
    EntityLoad("data/entities/buildings/forge_item_convert.xml", pos_x, pos_y)
    GamePlaySound( "data/audio/Desktop/projectiles.snd", "projectiles/magic/create", pos_x, pos_y )
end