local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetRootEntity(entity_id)
local pos_x, pos_y = EntityGetTransform(entity_id)
local damage_comp = EntityGetFirstComponentIncludingDisabled(parent_id,"DamageModelComponent")
local vsc_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
if ComponentGetValue2(damage_comp,"wait_for_kill_flag_on_death") == false then ComponentSetValue2(damage_comp,"wait_for_kill_flag_on_death",true) end
local death_init_frame = ComponentGetValue2(vsc_comp,"value_int")
local death_initialized = ComponentGetValue2(vsc_comp,"value_bool")
local current_frame = GameGetFrameNum()
local sprite_comp = EntityGetFirstComponentIncludingDisabled(entity_id,"SpriteComponent")

local book_vsc_comps = EntityGetComponentIncludingDisabled(parent_id,"VariableStorageComponent")
local state_data = book_vsc_comps[2]
local book_state = ComponentGetValue2(state_data,"value_int")
local book_state_timer = ComponentGetValue2(state_data,"value_float")
local children = EntityGetAllChildren(entity_id) or {}

local book_states = {
    closed = 0,
    opening = 1,
    closing = 2,
    open = 3,
}

function playAnimation(animation_to_play)
    local sprite_comps = EntityGetComponentIncludingDisabled(parent_id,"SpriteComponent") or {}
    for k=1,#sprite_comps do
        ComponentSetValue2(sprite_comps[k],"rect_animation",animation_to_play)
    end
end

if death_init_frame == 0 then
    local hp = ComponentGetValue2(damage_comp,"hp")
    if hp <= 0 then
        ComponentSetValue2(vsc_comp,"value_int",current_frame) --Save the current frame as the death init frame
        ComponentSetValue2(state_data,"value_bool",true) --Disable the books ai
        EntitySetComponentIsEnabled( parent_id, damage_comp, false ) --Disable damage flashes
        ComponentSetValue2(state_data,"value_float",current_frame + 36)
    end
else
    if current_frame >= book_state_timer then
        if book_state == book_states.open or book_state == book_states.opening then
            playAnimation("closing")
            ComponentSetValue2(state_data,"value_float",current_frame + 32)
            ComponentSetValue2(state_data,"value_int",book_states.closing)
        elseif book_state == book_states.closing then
            playAnimation("closed")
            ComponentSetValue2(state_data,"value_float",current_frame + 99999)
            ComponentSetValue2(state_data,"value_int",book_states.closed)
        end
    end

    if book_state == book_states.closed then
        local sprite_comps = EntityGetComponentIncludingDisabled(parent_id,"SpriteComponent") or {}
        local fade_in_length = 90
        local metamorphasis_animation_time = math.floor(60 * 0.2 * 6)
        local opacity = math.min(1,(current_frame - death_init_frame) / fade_in_length)

        if death_initialized == false then
            local particles = EntityLoad("data/entities/animals/enchanted_books/particles/death_particles.xml",pos_x,pos_y)
            EntityAddChild(entity_id,particles)
            ComponentSetValue2(vsc_comp,"value_int",current_frame)
            ComponentSetValue2(vsc_comp,"value_bool",true)
        end

        ComponentSetValue2(sprite_comp,"alpha",opacity)
        if current_frame == death_init_frame + fade_in_length then
            for k=1,#sprite_comps do
                ComponentSetValue2(sprite_comps[k],"alpha",0)
                ComponentSetValue2(sprite_comp,"rect_animation","metamorphasis")
            end
        elseif current_frame >= death_init_frame + fade_in_length + metamorphasis_animation_time then
            local book = EntityLoad("mods/Apotheosis/files/entities/items/pickups/spellbook_base.xml",pos_x,pos_y)
            StatsLogPlayerKill( parent_id )
            EntityKill(parent_id)
        end
    end
end


--Disable the book attacking
--Disable the book opening & closing (enable a "manual control" variable?)
--Ensure the book is closed
--Spawn the death particles
--Create a magical cloud and conjure the tome item