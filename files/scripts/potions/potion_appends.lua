local mm_insert = {
    {
    material="apotheosis_mudman_mud",
    cost=1600,
    },
    {
    material="apotheosis_magic_liquid_infinite_flight",
    cost=800,
    },
    {
    material="apotheosis_magic_liquid_attunium",
    cost=800,
    },
    {
    material="apotheosis_magic_liquid_velocium",
    cost=800,
    },
}

--[[
for k, v in ipairs(ms_insert) do
table.insert(materials_standard, v)
end
]]--

for k=1,#mm_insert
do v = mm_insert[k]
    table.insert(materials_magic, v)
end