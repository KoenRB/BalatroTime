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


-- Rust Joker

SMODS.Joker {
  key="rust",
  pos={x=0,y=0},
  rarity=1,
  cost=3,
  blueprint_compat=true,
  discovered=true,

  config = { extra = {mult = 15, bought_at = 0} },

  add_to_deck = function(self, card, from_debuff)
    local now = (BalatroTime and BalatroTime.clock) or 0
    card.ability.extra.bought_at = now
  end,

  loc_vars = function(self, info_queue, card)
    local mult = card.ability.extra.mult or 15
    return { vars = { mult } }
  end,

  update = function(self, card, dt)
    local now = (BalatroTime and BalatroTime.clock) or 0
    local bought_at = card.ability.extra.bought_at or 0
    local elapsed = now - bought_at

    card.ability.extra.mult = 15 - (math.floor(elapsed / 15))
    if card.ability.extra.mult <= 0 then
      G.jokers:remove_card(self)
			card:remove()
    end
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local mult = card.ability.extra.mult or 15
      return { 
        card = card,
        mult_mod = mult,
        message = "+" .. mult
      }
    end
  end
}

-- Alarm Clock Joker
SMODS.Joker {
  key="alarm_clock",
  pos={x=0,y=0},
  rarity=1,
  cost=5,
  blueprint_compat=true,
  discovered=true,
  config = { extra = { chips = 40, mult = 5, bought_at = 0, time_left = 60 } },
  add_to_deck = function(self, card, from_debuff)
    local now = (BalatroTime and BalatroTime.clock) or 0
    card.ability.extra.bought_at = now
  end,
  
  loc_vars = function(self, info_queue, card)
    return { vars = { 
      card.ability.extra.chips, 
      card.ability.extra.mult, 
      card.ability.time_left
    } }
  end,

  update = function(self, card, dt)
    local now = (BalatroTime and BalatroTime.clock) or 0
    local bought_at = card.ability.extra.bought_at or 0
    card.ability.time_left = 60 - math.floor(now - bought_at)
    if card.ability.time_left <= 0 then
      G.jokers:remove_card(self)
			card:remove()
    end
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      return { 
        card = card,
        chip_mod = card.ability.extra.chips,
        mult_mod = card.ability.extra.mult,
        message = "+" .. card.ability.extra.chips .. " chips   +" .. card.ability.extra.mult .. " mult"
      }
    end
  end
}