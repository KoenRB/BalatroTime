-- Hourglass Joker
-- src/jokers.lua
-- Note; Running on an older version of SMODS such that chips and mult are chip_mod and mult_mod (modern versions seem to be backwards compatible)


BalatroTime = BalatroTime or {}
BalatroTime.hourglass_listeners = BalatroTime.hourglass_listeners or {}

-- Hourglass Joker

local function hourglass_chips(card)
  local bt = (card.ability.extra and card.ability.extra.bought_at) or 0
  local now = (BalatroTime and BalatroTime.clock) or 0
  return math.floor(math.max(0, now - bt) / 5)
end

SMODS.Joker {
  key="hourglass",
  pos={x=0,y=0},
  rarity=1,
  cost=3,
  blueprint_compat=false,
  discovered=true,

  config = { extra = {chips = 0, bought_at = 0} },

  loc_vars = function(self, info_queue, card)
    return { vars = { hourglass_chips(card) } }
  end,

  add_to_deck = function(self, card, from_debuff)
    local now = (BalatroTime and BalatroTime.clock) or 0
    card.ability.extra.bought_at = now
  end,

  calculate = function(self, card, context)
    if context.joker_main then
        card.ability.extra.chips = hourglass_chips(card)
        return { 
            card = card,
            chip_mod = card.ability.extra.chips,
            message = "+" .. card.ability.extra.chips
        }
    end
  end
}




