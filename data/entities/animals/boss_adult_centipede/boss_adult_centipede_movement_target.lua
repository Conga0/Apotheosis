function get_magnitude( x, y )
	local result = math.sqrt( x ^ 2 + y ^ 2 )
	return result
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local parent_id = EntityGetParent(entity_id)
local pos_x, pos_y = EntityGetTransform(parent_id)
local wormComp = EntityGetFirstComponentIncludingDisabled(parent_id,"WormComponent")
local wormAiComp = EntityGetFirstComponentIncludingDisabled(parent_id,"WormAIComponent")
local target_id = ComponentGetValue2(wormAiComp,"mTargetEntityId")
local player_id = EntityGetClosestWithTag(x, y, "player_unit")
if player_id == nil then
    player_id = EntityGetClosestWithTag(x, y, "polymorphed_player")
    if player_id == nil then
	EntityKill(entity_id)
    end
end
local targ_x, targ_y = EntityGetTransform(player_id)

local varcomp = EntityGetFirstComponentIncludingDisabled(entity_id,"VariableStorageComponent")
local delay = ComponentGetValue2(varcomp,"value_int") --Delay timer [Unused]
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
local cooldown_frame = ComponentGetValue2( centivarcomp, "value_int" ) --[Unused]

-- If Centi took 7 seconds too long to get to a point and went to the next phase then delete self
if laser_stage == 1 then
    EntityKill(entity_id)
end

-- Phase 0 - Initalization phase, get offset position above/below player and the opposing position based on the centi and player and log it down
-- Phase 1 - Follow above player until centi gets close enough
-- Phase 2 - Swap to opposing position and then delete after centi gets close

local centifound = false

if phase == 0 then

    local a_x = pos_x - targ_x
    local a_y = pos_y - targ_y
    
    local o_x = (a_x * -1) / 2
    local o_y = (a_y * -1) / 2
    ComponentSetValue2(poscomp1,"value_int",o_x)
    ComponentSetValue2(poscomp1,"value_float",o_y)

    local s_x = (x - targ_x) / 2
    local s_y = ((y - targ_y) / 4 ) * 3

    local max_dist = 400

    if ( s_y >= max_dist ) and ( s_x >= max_dist ) then
	s_x = max_dist
	s_y = max_dist
    elseif ( s_y >= max_dist ) then
	s_y = max_dist
    elseif ( s_x >= max_dist ) then
	s_x = max_dist
    end

    ComponentSetValue2(poscomp2,"value_int",s_x)
    ComponentSetValue2(poscomp2,"value_float",s_y)

    --print("wowza")

    ComponentSetValue2(varcomp,"value_float",1)

elseif phase == 1 then

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

    local nx = targ_x + pos_sidex
    local ny = targ_y + pos_sidey
    ComponentSetValue2( wormComp, "mTargetPosition", nx, ny )
    EntitySetTransform(entity_id, nx, ny)

    --[[
    local centi = EntityGetInRadiusWithTag( nx, ny, 10, "boss_dragon") or {}
    for k=1,#centi
    do local v = centi[k]
	if ( v ~= entity_id ) and ( v == parent_id ) and ( EntityGetName(v) == "Adult Centipede" ) then
	    centifound = true
	    break
	end
    end
    ]]--

    local dis_x = nx - pos_x
    local dis_y = ny - pos_y

    local distance = get_magnitude(dis_x, dis_y)

    if distance <= 20 then
	centifound = true
    end

    if centifound == true then
	ComponentSetValue2(varcomp,"value_float",2)
	EntitySetTransform(entity_id, targ_x + pos_opposex, targ_y + pos_opposey)
	--print("phase 2")
    end
elseif phase == 2 then

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

    local nx = targ_x + pos_opposex
    local ny = targ_y + pos_opposey
    ComponentSetValue2( wormComp, "mTargetPosition", nx, ny )
    EntitySetTransform(entity_id, nx, ny)

    --[[
    local centi = EntityGetInRadiusWithTag( nx, ny, 10, "boss_dragon") or {}
    for k=1,#centi
    do local v = centi[k]
	if ( v ~= entity_id ) and ( v == parent_id ) then
	    centifound = true
	    break
	end
    end
    ]]--

    local dis_x = nx - pos_x
    local dis_y = ny - pos_y

    local distance = get_magnitude(dis_x, dis_y)

    if distance <= 25 then
	centifound = true
    end

    if centifound == true then --(current_frame >= delay)
	ComponentSetValue2( centivarcomp, "value_int", current_frame + 2 )
	--print("defeat")
	EntityKill(entity_id)
    end
end