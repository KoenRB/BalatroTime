-- Hourglass Joker
-- src/jokers.lua
BalatroTime = BalatroTime or {}
BalatroTime.hourglass_listeners = BalatroTime.hourglass_listeners or {}

-- Helper: register a per-card timer "since bought"
function BalatroTime.register_hourglass(card)
  -- store the purchase timestamp in *global clock seconds*
  -- so it scales properly with speed settings
  card.ability.balatro_time = card.ability.balatro_time or {}
  card.ability.balatro_time.bought_at = BalatroTime.clock or 0
end

-- Helper: compute chips based on elapsed time since bought
local function hourglass_chips(card)
  local bt = (card.ability.balatro_time and card.ability.balatro_time.bought_at) or (BalatroTime.clock or 0)
  local elapsed = math.max(0, (BalatroTime.clock or 0) - bt)
  -- +1 chip every 5 seconds
  return math.floor(elapsed / 5)
end

SMODS.Joker {
  key = "hourglass",
  -- TEMP ART: point at a vanilla joker slot in the default joker atlas
  -- Change these later to your own atlas + pos.
  atlas = "jokers",
  pos = { x = 0, y = 0 },

  rarity = 1,               -- Common
  blueprint_compat = true,
  cost = 3,
  discovered = true,

  config = {
    extra = {
      -- no static scaling needed; chips are derived from elapsed time
    }
  },

  loc_vars = function(self, info_queue, card)
    -- show current chip value in the text
    return { vars = { hourglass_chips(card) } }
  end,

  -- Hook: when the card is added/created, set bought_at
  -- Steamodded supports "add_to_deck" on Jokers; this is the cleanest.
  add_to_deck = function(self, card, from_debuff)
    BalatroTime.register_hourglass(card)
  end,

  calculate = function(self, card, context)
    -- Provide chips at scoring time
    if context.joker_main then
      local chips = hourglass_chips(card)
      if chips > 0 then
        return { chips = chips }
      end
    end
  end,
}


-- Example Jokers below

-- Joker
SMODS.Joker {
    key = "joker",
    pos = { x = 0, y = 0 },
    rarity = 1,
    blueprint_compat = true,
    cost = 2,
    discovered = true,
    config = { extra = { mult = 4 }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Greedy Joker
SMODS.Joker {
    key = "greedy_joker",
    pos = { x = 6, y = 1 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    config = { extra = { s_mult = 3, suit = 'Diamonds' }, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.s_mult, localize(card.ability.extra.suit, 'suits_singular') } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit(card.ability.extra.suit) then
            return {
                mult = card.ability.extra.s_mult
            }
        end
    end
}

