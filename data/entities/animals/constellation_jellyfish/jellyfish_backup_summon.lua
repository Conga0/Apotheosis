local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

local backup = EntityLoad("data/entities/animals/constellation_jellyfish.xml",pos_x,pos_y)
local backup_comps = EntityGetComponentIncludingDisabled(backup,"VariableStorageComponent")
ComponentSetValue2(backup_comps[1],"value_bool",true) --Enable aggressive ai
ComponentSetValue2(backup_comps[1],"value_float",1.0) --Prevent backup jellyfish from calling for more backup

--[[
local backup_children = EntityGetAllChildren(backup)
for k=1,2 do
    local backup_tendril_lua = EntityGetFirstComponentIncludingDisabled(backup_children[k],"LuaComponent")
    EntitySetComponentIsEnabled( backup_children[k], backup_tendril_lua, false )
end
]]--

--Let the backup jellyfish die
EntityAddTag(backup,"miniboss")
EntityAddTag(backup,"minion")
local dmgcomp = EntityGetFirstComponentIncludingDisabled(backup,"DamageModelComponent")
ComponentSetValue2(dmgcomp,"kill_now",true)

--Enable aggressive ai comps
EntitySetComponentsWithTagEnabled( backup, "invincible", true )



local paicomp = EntityGetFirstComponentIncludingDisabled(backup,"PhysicsAIComponent")
ComponentSetValue2(paicomp,"target_vec_max_len",24)
ComponentSetValue2(paicomp,"force_coeff",16.0)
ComponentSetValue2(paicomp,"force_max",200)

EntityKill(entity_id)