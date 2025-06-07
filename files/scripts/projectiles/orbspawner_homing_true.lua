local entity_id    = GetUpdatedEntityID()
local pos_x,pos_y = EntityGetTransform(entity_id)
EntitySetComponentsWithTagEnabled(entity_id,"invincible",false)
GamePlaySound( "data/audio/Desktop/explosion.bank", "explosions/magic_rocket_big", pos_x, pos_y )
