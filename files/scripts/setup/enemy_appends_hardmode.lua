
if g_big_enemies ~= nil then
    for k=1,#g_big_enemies
    do local v = g_big_enemies[k]
        if v.ngpluslevel and not v.ng_exclusive then
            v.ngpluslevel = v.ngpluslevel - 1
        end
    end
end

if g_small_enemies ~= 0 then
    for k=1,#g_small_enemies
    do local v = g_small_enemies[k]
        if v.ngpluslevel and not v.ng_exclusive then
            v.ngpluslevel = v.ngpluslevel - 1
        end
    end
end