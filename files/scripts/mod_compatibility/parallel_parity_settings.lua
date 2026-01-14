table.insert(ParallelParity_Settings.mod_compat_settings, {
    id = "apotheosis",
    type = "group",
    translations = {
        en = "Apotheosis"
    },
    items = {
        {
            id = "statue_room",
            value_default = true, --change
            translations = {
                en = "Statue Room",
                en_desc = "Should the Statue Room spawn in Parallel Worlds"
            },
        },
    },
})

ParallelParity_Settings.max_orbs = ParallelParity_Settings.max_orbs + 12