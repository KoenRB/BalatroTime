-- Hourglass Joker
SMODS.Sprite:new(
  "hourglass_joker",
  SMODS.current_mod.path,
  "hourglass_placeholder.png", -- temporary
  71, 95,
  "asset_atli"
):register()

local hourglass_def = {
  name = "Hourglass",
  text = {
    "Gains {C:chips}+1{} Chip",
    "every {C:attention}5{} seconds",
    "{C:inactive}(since bought){}"
  }
}

local hourglass = SMODS.Joker:new(
  "Hourglass",                 -- name
  "hourglass",                 -- slug
  {},                           -- no base ability values
  { x = 0, y = 0 },             -- atlas position (temp)
  hourglass_def,
  1,                            -- rarity (1 = common)
  5,                            -- cost
  true,                         -- unlocked
  false,                        -- discovered
  true,                         -- blueprint compatible
  true,                         -- eternal compatible
  "Chips",
  "hourglass_joker"
)

hourglass:register()




function SMODS.Jokers.j_hourglass.init(card)
  card.ability._time_acc = 0
  card.ability._chips = 0
end

function SMODS.Jokers.j_hourglass.calculate(card, context)
  if context.other_joker and context.other_joker == card then
    -- only tick if time is actually running
    if BalatroTime.paused then return end
    if G.STAGE ~= G.STAGES.RUN then return end

    local dt = context.other_joker_dt or 0
    local scaled_dt = dt * BalatroTime.speed

    card.ability._time_acc = card.ability._time_acc + scaled_dt

    while card.ability._time_acc >= 5 do
      card.ability._time_acc = card.ability._time_acc - 5
      card.ability._chips = card.ability._chips + 1
      card_eval_status_text(
        card,
        'extra',
        nil,
        nil,
        nil,
        { message = "+1 Chip", colour = G.C.CHIPS }
      )
    end
  end

  -- apply chips when scoring
  if context.cardarea == G.jokers and not context.before and not context.after then
    return {
      chip_mod = card.ability._chips,
      message = localize{
        type='variable',
        key='a_chips',
        vars={card.ability._chips}
      }
    }
  end
end

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

