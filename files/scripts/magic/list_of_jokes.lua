
local jokes = {
    "Why did the hamis cross the road? To get to the other side.",
    "A hiisi, a tank and a noita walk into a bar, they all die to the hidden propane tank.",
    "A noita steps foot into the laboratory and hears 'Sorry Noita, your sampo is in another castle'.",
    "What happens when you combine a Cat with Kolmi? Nekolmisilma!",
    "What's a wand of swiftness users favourite food? Spam",
    "Why do Muodonmuutosmestari never go on adventures? Because they're sheepish!"
}

function RandomJoke()
    SetRandomSeed(5+6+7+0+9,666+999)
    local shuffled_jokes = {}
    for k=1,#jokes do
        local rng = Random(1,#jokes)
        table.insert(shuffled_jokes,jokes[rng])
        table.remove(jokes,rng)
    end
    local joke = jokes[Random(1,#jokes)]
    return joke
end