
function death()
	local entity_id = GetUpdatedEntityID()

	local children = EntityGetAllChildren(entity_id)
	for k=1,#children
	do local v = children[k]
		if EntityHasTag(v,"mortal") then
			EntitySetComponentsWithTagEnabled(v,"invincible",false)

			local comp = EntityGetFirstComponentIncludingDisabled(v,"HitboxComponent")
			ComponentSetValue2(comp,"damage_multiplier",1)
			EntityRemoveFromParent(v)
		end
	end
end
