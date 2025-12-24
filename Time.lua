--- STEAMODDED HEADER
--- MOD_NAME: Balatro Time
--- MOD_ID: BalatroTime
--- MOD_VERSION: 1.0.0
--- MOD_AUTHOR: [Koenrb]
--- MOD_DESCRIPTION: Adds time as a resource to the game, used for various time-based mechanics.
--- BADGE_COLOUR: #FFD700
--- PRIORITY: -100
----------------------------------------------
------------MOD CODE -------------------------

function SMODS.INIT.BalatroTime()
  BalatroTime.init()
  assert(SMODS.load_file("overrides.lua"))()
  assert(SMODS.load_file("src/jokers.lua"))()
  assert(SMODS.load_file("src/tarots.lua"))()
  assert(SMODS.load_file("src/editions.lua"))()
  assert(SMODS.load_file("src/seals.lua"))()
  assert(SMODS.load_file("src/vouchers.lua"))()
  assert(SMODS.load_file("src/spectrals.lua"))()
  assert(SMODS.load_file("src/challenges.lua"))()
end
