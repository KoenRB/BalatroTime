SMODS.Stake {
    name = "Black Stake",
    key = "black",
    unlocked_stake = "blessed",
    applied_stakes = { "green" },
    pos = { x = 4, y = 0 },
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_eternals_in_shop = true
    end,
    colour = G.C.BLACK,
}


SMODS.Stake {
    name = "Blessed Stake",
    key = "blessed",
    unlocked_stake = "blue",
    applied_stakes = { "black" },
    above_stake = "black",
    pos = { x = 3, y = 0 },
    sticker_pos = { x = 4, y = 0 },
    modifiers = function()
        G.GAME.starting_params.blessed_odds = 0.05
    end,
    colour = HEX('add8e6')
}


SMODS.Stake {
    name = "Blue Stake",
    key = "blue",
    unlocked_stake = "purple",
    applied_stakes = { "blessed" },
    pos = { x = 3, y = 0 },
    sticker_pos = { x = 4, y = 0 },
    modifiers = function()
        G.GAME.starting_params.discards = G.GAME.starting_params.discards - 1
    end,
    colour = G.C.BLUE,
}