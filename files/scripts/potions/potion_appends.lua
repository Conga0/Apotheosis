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
}

--[[
for k, v in ipairs(ms_insert) do
table.insert(materials_standard, v)
end
]]--

for k, v in ipairs(mm_insert) do
table.insert(materials_magic, v)
end