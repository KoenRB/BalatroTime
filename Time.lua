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

BalatroTime = BalatroTime or {}

function SMODS.INIT.BalatroTime()
  
  
  assert(SMODS.load_file("Localization/en-us.lua"))()
  BalatroTime = BalatroTime or {}

  local function merge_localization(loc)
    if not loc or not loc.descriptions then return end
    G.localization.descriptions = G.localization.descriptions or {}

    for set_name, set_tbl in pairs(loc.descriptions) do
      G.localization.descriptions[set_name] = G.localization.descriptions[set_name] or {}
      for key, def in pairs(set_tbl) do
        G.localization.descriptions[set_name][key] = def
      end
    end
  end

  assert(SMODS.load_file("overrides.lua"))()
  assert(SMODS.load_file("src/jokers.lua"))()
  assert(SMODS.load_file("src/vouchers.lua"))()
  BalatroTime.init()

  assert(SMODS.load_file("src/tarots.lua"))()
  assert(SMODS.load_file("src/enhancements.lua"))()
  assert(SMODS.load_file("src/editions.lua"))()
  assert(SMODS.load_file("src/seals.lua"))()

  assert(SMODS.load_file("src/spectrals.lua"))()
  assert(SMODS.load_file("src/challenges.lua"))()
end
