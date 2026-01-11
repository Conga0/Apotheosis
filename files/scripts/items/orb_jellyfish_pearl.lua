
function death( damage_type_bit_field, damage_message, entity_thats_responsible, drop_items )
	local entity_id    = GetUpdatedEntityID()
    local pos_x,pos_y = EntityGetTransform(entity_id)

   EntityLoad("mods/Apotheosis/files/entities/particle_generators/jellyfish_particles.xml",pos_x,pos_y)
end

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
local paper_books = EntityGetInRadiusWithTag(pos_x,pos_y,70,"paper_book") or {}
local book_present = false
for k=1,#paper_books do
    local v = paper_books[k]
    if EntityGetRootEntity(v) == v then
        book_present = true
    end
end

if book_present then
    EntityAddTag(entity_id,"forgeable")
else
    EntityRemoveTag(entity_id,"forgeable")
end