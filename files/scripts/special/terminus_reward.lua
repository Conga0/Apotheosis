
local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local vcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local progress = ComponentGetValue2(vcomp,"value_int")
local increment = math.max(0,1.0 - (progress * 0.01))
local spritecomp2 = EntityGetComponentIncludingDisabled(entity_id,"SpriteComponent")[2]
EntitySetTransform(entity_id,pos_x,pos_y - increment)

local pcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"ParticleEmitterComponent")
--Make particles spawn faster over time
ComponentSetValue2(pcomp,"emission_interval_min_frames",math.max(1,5 - math.ceil(progress * 0.1)))
ComponentSetValue2(pcomp,"emission_interval_max_frames",math.max(1,13 - math.ceil(progress * 0.1)))

--Make more particles spawn over time
ComponentSetValue2(pcomp,"count_min",math.min(16,4 + math.floor(progress * 0.05)))
ComponentSetValue2(pcomp,"count_max",math.min(32,8 - math.floor(progress * 0.05)))

--Slowly bring shimmer in
ComponentSetValue2(spritecomp2,"alpha",math.min(1,-1+(progress*0.005)))

--Progressively faster lightning strikes
for k=1,16 do
    if progress == (600 - math.ceil(600 * 0.70^k)) or (progress > 580 and progress % 4 == 0) then
        SetRandomSeed(progress+GameGetFrameNum(),pos_x+pos_y)
        dofile_once("data/scripts/lib/utilities.lua")
        local angle = math.rad(Random(0,359))
        local length = 3000
        
        local vel_x = math.cos( angle ) * length
        local vel_y = 0 - math.sin( angle ) * length
        shoot_projectile( entity_id, "data/entities/projectiles/deck/lightning_extra_arcs.xml", pos_x, pos_y, vel_x, vel_y )
    end
end

--Increment progress counter
ComponentSetValue2(vcomp,"value_int",progress+1)

--Increase particle glow
if progress == 300 then
    ComponentSetValue2(pcomp,"emitted_material_name","spark_red_bright")
end

--Final, Single dense ring of particles
if progress == 515 then
    EntitySetComponentsWithTagEnabled(entity_id,"enabled_by_script",true)
	GameTriggerMusicEvent( "music/oneshot/dark_03", true, pos_x, pos_y )
else
    EntitySetComponentsWithTagEnabled(entity_id,"enabled_by_script",false)
end

--End reward
if progress > 600 then
    EntityKill(entity_id)
	LoadPixelScene( "mods/Apotheosis/files/projectiles_gfx/terminus/terminus_shatter.png", "mods/Apotheosis/files/projectiles_gfx/terminus/terminus_shatter_visual.png", pos_x-16, pos_y-16, "", true )
    EntityLoad("mods/Apotheosis/files/projectiles_gfx/terminus/repulsion.xml",pos_x,pos_y)
    GamePlaySound( "data/audio/Desktop/misc.bank", "game_effect/frozen/damage", pos_x, pos_y )
    local spell_id = CreateItemActionEntity( "APOTHEOSIS_SPELL_WORM", pos_x, pos_y )
    local svcomp = EntityGetFirstComponentIncludingDisabled(spell_id,"VelocityComponent")
    ComponentSetValue2(svcomp,"gravity_y",20)

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
	GamePlaySound( "data/audio/Desktop/misc.bank", "misc/chest_dark_open", pos_x, pos_y )
    AddFlagPersistent("apotheosis_terminus_complete")
end