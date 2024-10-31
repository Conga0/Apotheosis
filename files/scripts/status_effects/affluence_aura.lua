
local entity_id = GetUpdatedEntityID() 
local x,y = EntityGetTransform(entity_id)
local targets = EntityGetInRadiusWithTag(x,y,15,"enemy")

for k=1,#targets
do local v = targets[k]
    local kids = EntityGetAllChildren(v)
    if kids ~= nil then
        local alreadyboosted = false
        for z=1,#kids
        do local c = kids[z]
            if EntityGetName(c) == "apotheosis_goldboost_affluence" then
                alreadyboosted = true
                GamePrint("Found already boosted creature")
                break
            end
        end
        if alreadyboosted ~= true then
            local goldbuff = EntityLoad("mods/Apotheosis/files/entities/misc/drop_gold.xml")
            EntityAddChild(v,goldbuff)
            EntityKill(entity_id)
            GamePrint("entity_id is " .. entity_id)
            GamePrint("Applied gold buff")
            break
        end
    end
end