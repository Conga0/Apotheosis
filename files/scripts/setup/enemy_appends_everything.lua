
if g_big_enemies then
    for k=1,#g_big_enemies
    do local v = g_big_enemies[k]
        if v.ngpluslevel and not v.ng_exclusive then
            v.ngpluslevel = v.ngpluslevel - 1
        end
    end
end

if g_small_enemies then
    for k=1,#g_small_enemies
    do local v = g_small_enemies[k]
        if v.ngpluslevel and not v.ng_exclusive then
            v.ngpluslevel = v.ngpluslevel - 1
        end
    end
end

if g_props then
    for k=1,#g_props
    do local v = g_props[k]
        if v.ngpluslevel and not v.ng_exclusive then
            v.ngpluslevel = v.ngpluslevel - 1
        end
    end
end

GameAddFlagRun("apotheosis_everything")
