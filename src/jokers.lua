-- Hourglass Joker
-- src/jokers.lua
-- Note; Running on an older version of SMODS such that chips and mult are chip_mod and mult_mod (modern versions seem to be backwards compatible)


BalatroTime = BalatroTime or {}

---- Common Jokers

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

  generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    -- (keep name handling if you want)
    if not full_UI_table.name then
      full_UI_table.name = localize({ type = "name", set = self.set, key = self.key, nodes = full_UI_table.name })
    end

    -- Ensure field exists so ref doesn't hit nil
    card.ability.time_left = card.ability.time_left or 60

    local time_ui = {
      { n = G.UIT.T, config = { text = "Time left: ", colour = G.C.UI.TEXT_DARK, scale = 0.32 } },
      {
        n = G.UIT.O,
        config = {
          object = DynaText({
            string = { { ref_table = card.ability, ref_value = "time_left" } },
            colours = { G.C.RED },
            silent = true,
            pop_in_rate = 9999999,
            min_cycle_time = 0,
            scale = 0.32,
          }),
        },
      },
      { n = G.UIT.T, config = { text = "s", colour = G.C.UI.TEXT_DARK, scale = 0.32 } },
    }
    desc_nodes[#desc_nodes+1] = {
      { n = G.UIT.T, config = { text = "+", colour = G.C.CHIPS, scale = 0.32 } },
      { n = G.UIT.T, config = { text = tostring(card.ability.extra.chips), colour = G.C.CHIPS, scale = 0.32 } },
      { n = G.UIT.T, config = { text = " chips and ", colour = G.C.UI.TEXT_DARK, scale = 0.32 } },
      { n = G.UIT.T, config = { text = "+", colour = G.C.MULT, scale = 0.32 } },
      { n = G.UIT.T, config = { text = tostring(card.ability.extra.mult), colour = G.C.MULT, scale = 0.32 } },
      { n = G.UIT.T, config = { text = " mult", colour = G.C.UI.TEXT_DARK, scale = 0.32 } },
    }

    desc_nodes[#desc_nodes + 1] = time_ui
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

---- Uncommon Jokers
-- Extinguisher: stops fire enhancement decay while in deck

-- Robin Hood Joker: moves x% of chips to mult, scales by 1% per 10sec in round

-- Fuse Joker: adds fire enhancement to 5 random cards in hand in 3min, destroys itself after
-- Sundial Joker: retriggers cards with the rank equal to the leading digit of the current time twice upon scoring
-- Supernova Joker: if time is less than 15 seconds, fills consumable slots with planet cards for played hand

-- Engineer Joker
SMODS.Joker {    
  key="engineer",    
  pos={x=0,y=0},    
  rarity=2,    
  cost = 6,    
  blueprint_compat=false,    
  discovered=true,    
  config = { extra = { next_voucher = "v_hypersonic" } },    
  loc_vars = function(self, info_queue, card)    
    return { vars = { card.ability.extra.next_voucher } }    
  end,
  add_to_deck = function(self, card, from_debuff)
    if G.GAME.used_vouchers["v_hypersonic"] then  
      card.ability.extra.next_voucher = "v_lightspeed"  
    end
  end,
  remove_from_deck = function(self, card, from_debuff)    
    -- Check which voucher to add based on what's owned  
    local voucher_to_add = "v_hypersonic"  
    if G.GAME.used_vouchers["v_hypersonic"] then  
      voucher_to_add = "v_lightspeed"  
    end  
      
    -- Add voucher to next shop queue    
    G.GAME.current_round.voucher = G.GAME.current_round.voucher or {spawn = {}}    
    G.GAME.current_round.voucher[#G.GAME.current_round.voucher + 1] = voucher_to_add    
    G.GAME.current_round.voucher.spawn[voucher_to_add] = true    
  end   
}

---- Rare Jokers
-- Fertilizer Joker: raises interest cap by 1 for every minute played this run
-- Angel Joker: if the current time contains 3 3s, create a prendulum spectral card

-- Freeze Joker
SMODS.Joker {
  key="freeze",
  pos={x=0,y=0},
  rarity=3,
  cost = 6,
  blueprint_compat=false,
  discovered=true,
  config = { extra = { } },
  loc_vars = function(self, info_queue, card)
    return { vars = {  } }
  end,
  add_to_deck = function(self, card, from_debuff)
    BalatroTime.pause_available = true
  end,
  remove_from_deck = function(self, card, to_debuff)
    BalatroTime.pause_available = false
    BalatroTime.paused = false
    BalatroTime.paused_text = "|>"
  end
}

-- Legendary Jokers

-- Chronos Joker: scales by 0.1 xmult per minute from being bought, adds blessed sticker to the joker on its right