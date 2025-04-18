local entity_id = GetUpdatedEntityID()
local children = EntityGetAllChildren(entity_id)
local children_tbl = {}
for k=1,#children do
    local child_id = children[k]
    local child_children = EntityGetAllChildren(child_id)
    for z=1,#child_children do
        local v = child_children[z]
        if EntityGetName(v) == "line_top" then
            t_x,t_y = EntityGetTransform(v)
            t_particle = EntityGetFirstComponentIncludingDisabled(v,"ParticleEmitterComponent")
            dud1,dud2,t_rotate = EntityGetTransform(v)
        elseif EntityGetName(v) == "line_mid" then
            m_x,m_y = EntityGetTransform(v)
            m_particle = EntityGetFirstComponentIncludingDisabled(v,"ParticleEmitterComponent")
            dud1,dud2,m_rotate = EntityGetTransform(v)
        elseif EntityGetName(v) == "line_bot" then
            b_x,b_y = EntityGetTransform(v)
            b_particle = EntityGetFirstComponentIncludingDisabled(v,"ParticleEmitterComponent")
            dud1,dud2,b_rotate = EntityGetTransform(v)
        end

    end
    local child_data = {t_particle,m_particle,b_particle,t_x,t_y,m_x,m_y,b_x,b_y,t_rotate,m_rotate,b_rotate}
    table.insert(children_tbl,child_data)
end

--Todo curve

for k=1,#children_tbl do
    local num = #children - (k - 1)
    if num == 5 then
        print("num is " .. num)
        print("targ_x is " .. children_tbl[num - 1][4])
        print("targ_y is " .. children_tbl[num - 1][5])
        print("1 targ_x is " .. children_tbl[num - 1][4])
        print("1 targ_y is " .. children_tbl[num - 1][5])
        print("2 targ_x is " .. children_tbl[num - 1][6])
        print("2 targ_y is " .. children_tbl[num - 1][7])
        print("3 targ_x is " .. children_tbl[num - 1][8])
        print("3 targ_y is " .. children_tbl[num - 1][9])
    end

    ComponentSetValue2(children_tbl[num][1], "mExPosition", children_tbl[num - 1][4], children_tbl[num - 1][5])
    ComponentSetValue2(children_tbl[num][2], "mExPosition", children_tbl[num - 1][6], children_tbl[num - 1][7])
    ComponentSetValue2(children_tbl[num][3], "mExPosition", children_tbl[num - 1][8], children_tbl[num - 1][9])
end
