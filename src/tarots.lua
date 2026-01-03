-- The Pyre
SMODS.Consumable {
    -- creates a tarot that adds the fire enhancement to 2 selected cards
    key = 'pyre',
    set = 'Tarot',
    atlas = 'pyre',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 2, mod_conv = m_fire },
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_fire, nil, true)
                    G.hand.highlighted[i].ability.extra.last_updated = (BalatroTime and BalatroTime.clock) or 0
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted
    end
}


-- testing for someone else
-- SMODS.Consumable {
--     key = 'hangedprint',
--     set = "Tarot",
--     pos = { x = 2, y = 1 },
--     config = { max_highlighted = 2, extra = {odds = 2} },
--     loc_vars = function(self, info_queue, card)
--         local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'withering_chance')
--         return { vars = { card.ability.max_highlighted, n, d } }
--     end,
--     use = function(self, card, area, copier)
--         local targets = G.hand.highlighted
--         G.E_MANAGER:add_event(Event({
--             trigger = 'after',
--             delay = 0.4,
--             func = function()
--                 play_sound('tarot1')
--                 card:juice_up(0.3, 0.5)

--                 for i = 1, #targets do
--                     local c = targets[i]

--                     c.debuff = true
--                     c:juice_up(0.25, 0.3)

--                     if SMODS.pseudorandom_probability(
--                         card,
--                         'geekedupplayingbalatroallday' .. i,
--                         1,
--                         card.ability.odds
--                     ) then
--                         c.ability.repetitions = (c.ability.repetitions or 0) + 1
--                         play_sound('bd_inapmit', 1, 0.7)
--                     end
--                 end
--                 return true
--             end
--         }))
--         delay(0.6)
--     end
-- }