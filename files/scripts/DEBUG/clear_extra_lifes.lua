local entity_id = GetUpdatedEntityID()
local children = EntityGetAllChildren(entity_id) or {}

for k=1,#children do
    local v = children[k]
    local comp = EntityGetFirstComponentIncludingDisabled(v,"GameEffectComponent") or false
    if comp ~= false then
        local effect = ComponentGetValue2(comp,"effect")
        if effect == "RESPAWN" then
            local respawncount = ComponentGetValue2(comp,"mCounter")
            if respawncount > 0 then
                EntityRemoveFromParent(v)
                EntityKill(v)

                for z=1,#children do
                    local comp2 = EntityGetFirstComponentIncludingDisabled(children[z],"UIIconComponent") or false
                    if comp2 ~= false then
                        local desc2 = ComponentGetValue2(comp2,"description")
                        if desc2 == "$perkdesc_respawn" then
                            EntityRemoveFromParent(children[z])
                            EntityKill(children[z])

                            local x,y = EntityGetTransform(entity_id)
                            local child = EntityLoad("mods/Apotheosis/files/entities/misc/perks/respawn_spent.xml",x,y)
                            EntityAddChild(entity_id,child)
                            break
                        end
                    end
                end
            end
        end
    end
end
