local textComponent = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "SpriteComponent", "graham_speech_text")
if textComponent then EntityRemoveComponent(GetUpdatedEntityID(), textComponent) end
EntityRemoveTag(GetUpdatedEntityID(), "graham_speaking")