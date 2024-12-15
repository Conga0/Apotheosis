local ew_api = dofile_once("mods/quant.ew/files/api/ew_api.lua")
local rpc = ew_api.new_rpc_namespace("apotheosis")
function rpc.send_proj(peer_id, x, y, aim_x, aim_y, file)
    local ent = ctx.players[peer_id].entity
    if ent ~= nil then
        GameShootProjectile(ent, x+aim_x*12, y+aim_y*12, x+aim_x*20, y+aim_y*20, EntityLoad(file, x, y))
    end
end
util.add_cross_call("apoth_ew_alt_fire", function(ent, x, y, aim_x, aim_y, file)
    if ent == ctx.my_player.entity then
        rpc.send_proj(ctx.my_id, x, y, aim_x, aim_y, file)
    end
end)
return {}