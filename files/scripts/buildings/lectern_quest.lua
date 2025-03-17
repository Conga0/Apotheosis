local entity_id = GetUpdatedEntityID()
local x,y = EntityGetTransform(entity_id)
local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local timer = ComponentGetValue2(comp,"value_int")
local fail_count = tonumber(ComponentGetValue2(comp,"value_string"))

local targets = EntityGetInRadiusWithTag(x,y,300,"vegetation")
for k=1,#targets do
    EntityKill(targets[k])
end

function rings(entity_id, orbcount, radius)

	local function color(i)
		if not evil then
			return table.concat{math.random(1,9),"_",i%14+1}
		else
			return table.concat{"c_",math.random(1,9),"_",math.random(1,4)}
		end
	end

	if orbcount>0 and not EntityHasTag(entity_id, "projectile_cloned")then
		-- Add visual rings. +1 ring per 7.5 orbs.
		for j=1, math.min(math.floor(orbcount/7.5)+1, 5) do
			local ring = EntityCreateNew(tostring(radius))
			EntityAddChild(entity_id, ring)
			for i=1, math.floor((math.pi*radius)/6) do
				EntityAddComponent2(ring, "SpriteComponent", {
					image_file=table.concat{"mods/Apotheosis/files/particles/knowledge/", color(i), ".png"},--image_file="data/debug/circle_16.png",
					has_special_scale=true,
					emissive=true,
					additive=not evil,
					special_scale_x=1,
					special_scale_y=1,
					offset_x=5,
					offset_y=5,
					alpha=0.3+math.random()*0.1,
				})
			end
			EntityAddComponent2(ring, "LuaComponent", {script_source_file=table.concat{"mods/Apotheosis/files/scripts/projectiles/orb_knowledge_ring", j==1 and "_1" or "", ".lua"}})
			EntityAddComponent2(ring, "InheritTransformComponent", {only_position=true})
		end
	end
end

function insult_player()
    
    local insult = table.concat({"$message_apotheosis_insult_wiseguy_",fail_count})
    if GameTextGetTranslatedOrNot(insult) ~= "\"\"" then
        GamePrint(insult)
    end

    if fail_count % 8 == 0 then
        GamePrint(table.concat({"$message_apotheosis_insult_wiseguy_",fail_count,"_2"}))
    end

    if fail_count < 28 then
        fail_count = fail_count + 1
        ComponentSetValue2(comp,"value_string",tostring(fail_count))
    end
end

function reject_player(player_id)
    --EntityInflictDamage( player_id, 0.8, "DAMAGE_CURSE", "$status_apotheosis_brain_damage_perma_name", "NONE", 0, 0, entity_id, x, y, 100 ) --Used to do 20 damage, disabling for now to not feel like you're punishing yourself for exploration
    local p_x, p_y = EntityGetTransform(player_id)
    local cdcomp = EntityGetFirstComponentIncludingDisabled(player_id,"CharacterDataComponent")
    local vel_x = p_x - x
    local vel_y = p_y - y
    ComponentSetValue2(cdcomp,"mVelocity",vel_x * 50,vel_y * 50)
    local stun = EntityLoad("data/entities/misc/effect_electricity.xml",x,y)
    EntityAddChild(player_id,stun)
    GamePlaySound( "data/audio/Desktop/explosion.bank", "explosions/electric", x, y )
    --insult_player()
end

function interacting( player_id, shrine_id, interactable_name )
    local orb_count = GameGetOrbCountThisRun()
    if orb_count > 4 then
        local comp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
        local timer = ComponentGetValue2(comp,"value_int")
        if timer == 0 then
            timer = GameGetFrameNum()
            ComponentSetValue2(comp,"value_int",timer)
            EntityLoad("mods/Apotheosis/files/entities/buildings/lectern_audio.xml",x,y)
        end
    else
        reject_player(player_id)
    end
end

function run_animation(timer)
    if timer < 1 then
        return
    end
    local current_frame = GameGetFrameNum()
    if current_frame > timer + 60 then
        EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_script", true )
    end
    if current_frame > timer + 260 then
        local parcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
        ComponentSetValue2(parcomp,"count_min",12)
        ComponentSetValue2(parcomp,"count_max",18)
    end
    if current_frame > timer + 600 then
        EntitySetComponentsWithTagEnabled( entity_id, "enabled_by_script", false )
        EntitySetComponentsWithTagEnabled( entity_id, "invincible", false )
        local spell_id = CreateItemActionEntity( "APOTHEOSIS_ORB_KNOWLEDGE", x , y )
        local svcomp = EntityGetFirstComponentIncludingDisabled(spell_id,"VelocityComponent")
        ComponentSetValue2(svcomp,"gravity_y",0)
    
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
        GamePlaySound( "data/audio/Desktop/event_cues.bank", "event_cues/orb/create", x, y )
        GameTriggerMusicEvent( "music/oneshot/05", true, x, y )
        if fail_count > 22 then
            GamePrint("Greetings, I assume you are possessing this body. It was not the smartest before you entered it.")
        end
        AddFlagPersistent("apotheosis_lectern_quest")
        EntityKill(entity_id)
    end
end

local player_count = #(EntityGetInRadiusWithTag(x,y,256,"player_unit") or {})

if timer == -1 then
    ComponentSetValue2(comp,"value_int",0)
    rings(entity_id, 33, 6*33^0.5)
end

if player_count > 0 then

    local orb_count = GameGetOrbCountThisRun()
    if orb_count > 4 then
        run_animation(timer)
    end
end

