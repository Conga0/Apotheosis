dofile_once("data/scripts/lib/utilities.lua")

-- 1 = Item
-- 2 = Spell
-- 3 = Perk

local prizePool = {
    "data/entities/projectiles/rain_gold.xml",
}

function item_pickup( entity_item, entity_who_picked, name )
	local entity_id = GetUpdatedEntityID()
	local x,y = EntityGetTransform(entity_id)
    SetRandomSeed( GameGetFrameNum(), x, y )
    local RewardType = Random(1, 3)





    -- reward


    prizeSpells = {"apotheosis_BOMB_GIGA", }


    EntityKill( entity_item )

end

function physics_body_modified( is_destroyed )
	-- GamePrint( "A chest was broken open" )
	-- GameTriggerMusicCue( "item" )
	local entity_item = GetUpdatedEntityID()
end


"apotheosis_SAWBLADE_BIG_RAY", "apotheosis_SAWBLADE_BIG_RAY_ENEMY"