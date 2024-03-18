local entity_id = GetUpdatedEntityID()
local parent_id = EntityGetParent(entity_id)
local wormComp = EntityGetFirstComponentIncludingDisabled(parent_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(parent_id,"WormAIComponent")
local player_id = EntityGetWithTag("player_unit")[1]
local targ_x, targ_y = EntityGetTransform(player_id)
local x, y = EntityGetTransform(entity_id)

local varcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local delay = ComponentGetValue2(varcomp,"value_int") --Delay timer
local phase = ComponentGetValue2(varcomp,"value_float") --Current phase, above, side, etc

local poscomp1 = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")[2]
local poscomp2 = EntityGetComponentIncludingDisabled(entity_id,"VariableStorageComponent")[3]
local pos_opposex = ComponentGetValue2(poscomp1,"value_int") --Saved opposing position x
local pos_opposey = ComponentGetValue2(poscomp1,"value_float") --Saved opposing position y
local pos_sidex = ComponentGetValue2(poscomp2,"value_int") --Saved side position x
local pos_sidey = ComponentGetValue2(poscomp2,"value_float") --Saved side offset position y

local current_frame = GameGetFrameNum()
local centivarcomp = EntityGetComponentIncludingDisabled( parent_id, "VariableStorageComponent" )
for k=1,#centivarcomp
do local v = centivarcomp[k]
    if ComponentGetValue2(v,"name") == "basic_ai" then
        centivarcomp = v
        break
    end
end

local laser_stage = ComponentGetValue2( centivarcomp, "value_float" )
local cooldown_frame = ComponentGetValue2( centivarcomp, "value_int" )

ComponentSetValue2(wormAiComp,"mTargetEntityId",entity_id)

-- If Centi took 7 seconds too long to get to a point and went to the next phase then delete self
if laser_stage == 1 then
    EntityKill(entity_id)
end

-- Phase 0 - Initalization phase, get offset position above/below player and the opposing position based on the centi and player and log it down
-- Phase 1 - Follow above player until centi gets close enough
-- Phase 2 - Swap to opposing position and then delete after centi gets close

if phase == 0 then

    local pos_x, pos_y = EntityGetTransform(parent_id)
    local a_x = pos_x - targ_x
    local a_y = pos_y - targ_y
    
    local o_x = targ_x - a_x
    local o_y = targ_y - a_y
    ComponentSetValue2(poscomp1,"value_int",o_x)
    ComponentSetValue2(poscomp1,"value_float",o_y)

    local s_x = x - targ_x
    local s_y = y - targ_y

    ComponentSetValue2(poscomp2,"value_int",s_x)
    ComponentSetValue2(poscomp2,"value_float",s_y)

    local angle = math.atan2(targ_y - y, targ_x - x)
    local length = 200
    
    local ex = x + math.cos( angle ) * length
    local ey = y - math.sin( angle ) * length
    EntitySetTransform(entity_id, ex, ey)

    print("wowza")

    ComponentSetValue2(varcomp,"value_float",1)

    if delay == 0 then
        print("delayed")
        ComponentSetValue2(varcomp,"value_int",current_frame + 30)
    end

elseif phase == 1 and (current_frame >= delay) then

    --[[
    if(x > targ_x + pos_sidex + 1) then     
	x = targ_x + pos_sidex
    end
    if(x < targ_x + pos_sidex - 1) then
	x = targ_x + pos_sidex
    end
    if(y > targ_y + pos_sidey + 1) then
	y = targ_y + pos_sidey
    end
    if(y < targ_y + pos_sidey - 1) then
	y = targ_y + pos_sidey
    end
    ]]--

    x = targ_x + pos_sidex
    y = targ_y + pos_sidey
    EntitySetTransform(entity_id, x, y)

    print("lowza")

    if delay == 0 then
        print("delayed")
        ComponentSetValue2(varcomp,"value_int",current_frame + 20)
    end

    ComponentSetValue2(poscomp2,"value_int",s_x)
    ComponentSetValue2(poscomp2,"value_float",s_y)

    local angle = math.atan2(targ_y - y, targ_x - x) + math.pi / 2
    local length = 200
    
    local ex = x + math.cos( angle ) * length
    local ey = y - math.sin( angle ) * length

    ComponentSetValue2(varcomp,"value_float",2)
    

elseif phase == 2 and (current_frame >= delay) then

    --[[
    if(x > targ_x + pos_opposey + 1) then     
	x = targ_x + pos_opposex
    end
    if(x < targ_x + pos_opposey - 1) then
	x = targ_x + pos_opposex
    end
    if(y > targ_y + pos_opposey + 1) then
	y = targ_y + pos_opposey
    end
    if(y < targ_y + pos_opposey - 1) then
	y = targ_y + pos_opposey
    end
    ]]--

    x = targ_x + pos_opposex
    y = targ_y + pos_opposey
    
    local angle = math.atan2(targ_y - y, targ_x - x) + math.pi
    local length = 200
    
    local ex = x + math.cos( angle ) * length
    local ey = y - math.sin( angle ) * length

    print("powza")

    ComponentSetValue2( centivarcomp, "value_int", current_frame + (2 * 60) )
    EntityKill(entity_id)

    
	ComponentSetValue2( wormAiComp, "speed", 4 )
	ComponentSetValue2( wormAiComp, "speed_hunt", 4 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed", 0.05 )
	ComponentSetValue2( wormAiComp, "direction_adjust_speed_hunt", 0.05 )    

end