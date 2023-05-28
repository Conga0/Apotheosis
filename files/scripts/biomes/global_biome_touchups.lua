
if g_big_enemies ~= nil then
    for k=1,#g_big_enemies
    do local v = g_big_enemies[k]
        if v.max_count == 0 then
            v.prob = v.prob * 4
        end
    end
end

if g_small_enemies ~= 0 then
    for k=1,#g_small_enemies
    do local v = g_small_enemies[k]
        if v.max_count == 0 then
            v.prob = v.prob * 4
        end
    end
end