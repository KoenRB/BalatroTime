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
      SMODS.destroy_cards(card, nil, nil, true)
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
-- Extinguisher: TODO when new fire cards are added, extinguish them too
SMODS.Joker {  
  key = "extinguisher",  
  pos = {x=0, y=0},  
  rarity = 2,  
  cost = 6,  
  blueprint_compat = false,  
  discovered = true,  
  config = {extra = {}},  
  loc_vars = function(self, info_queue, card)  
    return { vars = {} }  
  end,  
  add_to_deck = function(self, card, from_debuff)  
    -- Pause fire enhancement decay for all cards  
    local areas = {G.deck, G.hand}  
    for _, area in ipairs(areas) do  
      if area and area.cards then  
        for _, playing_card in ipairs(area.cards) do  
          if playing_card.config.center.key == 'm_fire' then  
            playing_card.ability.extra.paused = true  
          end  
        end  
      end  
    end  
  end,  
  remove_from_deck = function(self, card, from_debuff)  
    -- Unpause fire enhancement decay for all cards  
    local areas = {G.deck, G.hand}  
    for _, area in ipairs(areas) do  
      if area and area.cards then  
        for _, playing_card in ipairs(area.cards) do  
          if playing_card.config.center.key == 'm_fire' then  
            playing_card.ability.extra.paused = false  
            playing_card.ability.extra.last_updated = BalatroTime.clock  
          end  
        end  
      end  
    end  
  end,  
  calculate = function(self, card, context)  
    if context.joker_main then  
      return {  
        message = "Fire Extinguished!",  
        colour = G.C.BLUE  
      }  
    end  
  end  
}

SMODS.Joker {    
  key = "robin_hood",    
  pos = {x=0, y=0},    
  rarity = 2,  
  cost = 6,  
  blueprint_compat = true,  
  discovered = true,  
  config = {  
    extra = {    
      base_percent = 0,  
      scaling_percent = 0.01,    
      scaling_time = 10,    
      round_start_time = 0    
    }    
  },    
  add_to_deck = function(self, card, from_debuff)  
    -- Initialize time once when joker is added  
    card.ability.extra.round_start_time = BalatroTime.clock or 0  
  end,  
  calculate = function(self, card, context)  
    -- Reset timer at start of each round  
    if context.setting_blind then  
      card.ability.extra.round_start_time = BalatroTime.clock or 0  
      return  
    end  
      
    -- Main effect: convert chips to mult    
    if context.joker_main then    
      local elapsed = (BalatroTime.clock or 0) - (card.ability.extra.round_start_time or 0)    
      local current_percent = card.ability.extra.base_percent + (math.floor(elapsed / card.ability.extra.scaling_time) * card.ability.extra.scaling_percent)    
          
      if current_percent > 0 and hand_chips > 0 then    
        local chips_to_convert = math.floor(hand_chips * current_percent)    
        local mult_gained = math.floor(chips_to_convert)    
            
        return {    
          chips = -chips_to_convert,    
          mult = mult_gained    
        }    
      end    
    end    
  end,  
  loc_vars = function(self, info_queue, card)    
    local elapsed = (BalatroTime.clock or 0) - (card.ability.extra.round_start_time or 0)    
    local current_percent = card.ability.extra.base_percent + (math.floor(elapsed / card.ability.extra.scaling_time) * card.ability.extra.scaling_percent)    
    return { vars = {     
      math.floor(current_percent * 100),     
      card.ability.extra.scaling_time,    
      math.floor(card.ability.extra.scaling_percent * 100)    
    }}      
  end  
}

-- Fuse Joker: destroys up to 5 random cards in hand in 3min, destroys itself after
SMODS.Joker {  
  key = "fuse",  
  pos = {x=0, y=0},  
  rarity = 2,  
  cost = 6,  
  blueprint_compat = false,  
  discovered = true,  
  config = {  
    extra = {  
      bought_at = 0,  
      destroy_time = 180,  
      destroy_count = 5,  
    }  
  },  
  loc_vars = function(self, info_queue, card)  
    -- Calculate time remaining  
    local time_elapsed = BalatroTime.clock - card.ability.extra.bought_at  
    local time_left = math.max(0, card.ability.extra.destroy_time - time_elapsed)  
      
    return {vars = {  
      time_left,  -- #1#: Time remaining until trigger  
      card.ability.extra.destroy_count  -- #2#: Cards to destroy  
    }}  
  end,  
  add_to_deck = function(self, card, from_debuff)  
    card.ability.extra.bought_at = BalatroTime.clock  
  end,  
  calculate = function(self, card, context)  
    if (not context.joker_main) then  
      if BalatroTime.clock - card.ability.extra.bought_at >= card.ability.extra.destroy_time then  
        if #G.hand.cards > 0 then  
          delay(0.2)  
          local destroyed_cards = {}  
          local destroyed_count = card.ability.extra.destroy_count  
          local temp_hand = {}  
  
          for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end  
            table.sort(temp_hand,  
              function(a, b)  
              return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card  
            end  
          )  
  
          pseudoshuffle(temp_hand, 'immolate')  
            
          if destroyed_count > #G.hand.cards then  
            destroyed_count =  #G.hand.cards  
          end  
  
          for i = 1, destroyed_count do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end  
  
          G.E_MANAGER:add_event(Event({  
              trigger = 'after',  
              delay = 0.4,  
              func = function()  
                  play_sound('tarot1')  
                  card:juice_up(0.3, 0.5)  
                  return true  
              end  
          }))  
          SMODS.destroy_cards(destroyed_cards)  
          -- Add delay before joker destruction    
          G.E_MANAGER:add_event(Event({    
              trigger = 'after',    
              delay = 0.3,    
              func = function()    
                SMODS.destroy_cards(card, nil, nil, true)    
                return true    
              end   
            })  
          )  
        end  
      end  
    end  
  end  
}

-- Sundial Joker: retriggers cards with the rank equal to the leading digit of the current time twice upon scoring
SMODS.Joker {  
  key = "sundial",  
  pos = {x=0, y=0},  
  rarity = 2,  
  cost = 6,  
  blueprint_compat = true,  
  discovered = true,  
  config = {  
    extra = {  
      retriggers = 2,  
    }  
  },  
  loc_vars = function(self, info_queue, card)  
    return {vars = {card.ability.extra.retriggers}}  
  end,  
  calculate = function(self, card, context)  
    if context.joker_main then  
      -- Get current time string using Balatro's time system  
      local time_string = BalatroTime.format_time(BalatroTime.clock)  
      local leading_digit  
        
      -- Extract first non-zero, non-colon digit  
      for char in time_string:gmatch(".") do    
          if char ~= "0" and char ~= ":" then    
              leading_digit = tonumber(char)    
              break    
          end    
      end  
        
      -- Apply retriggers to selected cards if we found a digit  
      if leading_digit and G.hand.selected and #G.hand.selected > 0 then  
        return {  
          retriggers = {  
            {  
              message = localize('k_again_ex'),  
              repetitions = card.ability.extra.retriggers,  
              card = card  
            }  
          }  
        }  
      end  
    end  
  end  
}

-- -- Supernova test
-- SMODS.Joker {
--   key = "supernova2",
--   pos = { x=0, y=0 },
--   cost = 6,
--   rarity = 2
-- }


-- Wormhole Joker: if time is less than 15 seconds, fills consumable slots with planet cards for played hand
SMODS.Joker {  
  key = "wormhole",  
  pos = { x=0, y=0 },  
  cost = 6,  
  rarity = 2,  
  blueprint_compat = true,  
  discovered = true,  
  config = {  
    extra = {  
      time_threshold = 15,  
    }  
  },  
  loc_vars = function(self, info_queue, card)  
    return {vars = {card.ability.extra.time_threshold}}  
  end,  
  calculate = function(self, card, context)  
    if context.playing_card_end_of_round and context.cardarea == G.hand and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then  
      -- Check if time is below threshold  
      if BalatroTime.clock < card.ability.extra.time_threshold and G.GAME.last_hand_played then  
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1  
        G.E_MANAGER:add_event(Event({  
          trigger = 'before',  
          delay = 0.0,  
          func = function()  
            -- Find planet cards for the played hand  
            local planets_for_hand = {}  
            for _, planet in pairs(G.P_CENTER_POOLS.Planet) do  
              if planet.config.hand_type == G.GAME.last_hand_played then  
                table.insert(planets_for_hand, planet)  
              end  
            end  
              
            -- Fill available consumable slots  
            local slots_filled = 0  
            local max_slots = G.consumeables.config.card_limit - #G.consumeables.cards  
              
            if #planets_for_hand > 0 and max_slots > 0 then  
              for i = 1, math.min(max_slots, #planets_for_hand) do  
                local planet_card = create_card('Planet', G.consumeables, nil, nil, nil, nil, planets_for_hand[i].key)  
                planet_card:add_to_deck()  
                slots_filled = slots_filled + 1  
              end  
                
              if slots_filled > 0 then  
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable', key='a_slots', vars={slots_filled}}})  
                play_sound('tarot1')  
                card:juice_up(0.3, 0.5)  
              end  
            end  
            G.GAME.consumeable_buffer = 0  
            return true  
          end  
        }))  
        return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }  
      end
    end
  end
}

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

SMODS.Joker {  
  key = "fertilizer",  
  pos = {x=0, y=0},  
  rarity = 3,  
  cost = 8,  
  blueprint_compat = false,  
  discovered = true,  
  config = {extra = {last_upgraded = 0, cap_increase = 0}},  
  loc_vars = function(self, info_queue, card)      
    return { vars = { card.ability.extra.cap_increase } }      
  end,  
  add_to_deck = function(self, card, from_debuff)  
    card.ability.extra.last_upgraded = (BalatroTime.clock or 0)  
  end,  
  remove_from_deck = function(self, card, from_debuff)  
    G.GAME.interest_cap = (G.GAME.interest_cap or 25) - (5 * card.ability.extra.cap_increase)  
    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "-" .. card.ability.extra.cap_increase .. " interest cap", colour = G.C.RED})
  end,
  update = function(self, card, dt)
    if BalatroTime.clock - card.ability.extra.last_upgraded >= 60 then
      G.GAME.interest_cap = G.GAME.interest_cap + 5
      card.ability.extra.last_upgraded = BalatroTime.clock
      card.ability.extra.cap_increase = card.ability.extra.cap_increase + 1
    end
  end
}
-- Angel Joker: if the current time contains 3 3s, create a prendulum spectral card
SMODS.Joker {  
  key = "angel",  
  pos = {x=0, y=0},  
  rarity = 3,  
  cost = 10,  
  blueprint_compat = false,  
  discovered = true,  
  config = {extra = {}},
  loc_vars = function(self, info_queue, card)  
    return { vars = {} }  
  end,  
  calculate = function(self, card, context)  
    if context.joker_main then  
      local time_string = BalatroTime.format_time(BalatroTime.clock or 0)  
        
      -- Count all occurrences of "3" in the time string  
      local count_3s = 0  
      for char in time_string:gmatch(".") do  
        if char == "3" then  
          count_3s = count_3s + 1  
        end  
      end  
        
      if count_3s >= 3 then 
        -- Create Pendulum spectral card  
        G.E_MANAGER:add_event(Event({  
          trigger = 'after',  
          delay = 0.4,  
          func = function()  
            if #G.consumeables.cards >= G.consumeables.config.card_limit then  
              return false  -- No space available  
            end 
            local spectral_card = SMODS.create_card({  
              key = "c_pendulum",  
              area = G.consumeables  
            })  
            spectral_card:add_to_deck()  
            G.consumeables:emplace(spectral_card)  
            return true  
          end  
        }))  
          
        return {  
          message = "Pendulum!",  
          colour = G.C.SPECTRAL  
        }  
      end  
    end  
  end  
}


-- Freeze Joker
SMODS.Joker {
  key="freeze",
  pos={x=0,y=0},
  rarity=3,
  cost = 8,
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
SMODS.Joker {  
  key = "chronos",  
  atlas = "chronos",
  pos = {x=0,y=0},  
  soul_pos = {x=1, y=0},
  rarity=4,  
  cost = 20,  
  blueprint_compat = true,  
  discovered = true,  
  config = {extra = {xmult = 1.0, scaling = 0.1, scaling_time = 30, bought_at = 0, blessing_cd = 60, last_blessing = 0}},  
  loc_vars = function(self, info_queue, card)  
    return { vars = {card.ability.extra.xmult, card.ability.extra.scaling, card.ability.extra.scaling_time}}  
  end,  
  add_to_deck = function(self, card, from_debuff)
    if not card.ability.extra.bought_at then
      card.ability.extra.bought_at = BalatroTime.clock  
      card.ability.extra.last_blessing = BalatroTime.clock 
    end 
  end,  
  update = function(self, card, dt)  
    local now = (BalatroTime and BalatroTime.clock) or 0  
    local bought_at = card.ability.extra.bought_at or 0  
    local elapsed = now - bought_at  
  
    -- Self scaling: update xmult based on elapsed time  
    local new_xmult = 1 + math.floor(elapsed / card.ability.extra.scaling_time) * card.ability.extra.scaling  
    if new_xmult ~= card.ability.extra.xmult then  
      card.ability.extra.xmult = new_xmult  
    end  
  
    -- Blessing logic: add Blessed Sticker to joker on right every 60 seconds  
    if now - card.ability.extra.last_blessing >= card.ability.extra.blessing_cd then  
      local joker_pos = nil  
      for i, joker in ipairs(G.jokers.cards) do  
        if joker == card then  
          joker_pos = i  
          break  
        end  
      end  
        
      if joker_pos and joker_pos < #G.jokers.cards then  
        local right_joker = G.jokers.cards[joker_pos + 1]  
        if right_joker and not right_joker.ability.blessed then  
          right_joker:add_sticker("blessed")  
          card.ability.extra.last_blessing = now  
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Blessed!", colour = G.C.PURPLE})  
        end  
      end  
    end  
  end,  
  calculate = function(self, card, context)  
    if context.joker_main then  
      return {Xmult = card.ability.extra.xmult}  
    end  
  end  
}