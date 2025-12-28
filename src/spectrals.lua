-- Pendulum Spectral: select 2 cards, they get a green or pink seal at random
SMODS.Consumable {  
    key = "pendulum",  
    set = "Spectral",  
    pos = {x = 1, y = 5},  
    config = { max_highlighted = 2 },  
  
    use = function(self, card, area, copier)  
        local used_tarot = copier or card  
        G.E_MANAGER:add_event(Event({  
            func = function()  
                play_sound('tarot1')  
                used_tarot:juice_up(0.3, 0.5)  
                return true  
            end  
        }))  
  
        -- Apply seals to each highlighted card  
        for i = 1, #G.hand.highlighted do  
            local conv_card = G.hand.highlighted[i]  
              
            G.E_MANAGER:add_event(Event({  
                trigger = 'after',  
                delay = 0.1,  
                func = function()  
                    -- Replace these with your actual custom seal keys  
                    local green_seal_key = "Green"
                    local pink_seal_key = "Pink"
                      
                    local seal_type = pseudorandom(pseudoseed('pendulum_seal'..i)) > 0.5 and green_seal_key or pink_seal_key  
                    conv_card:set_seal(seal_type, nil, true)  
                    return true  
                end  
            }))  
        end  
  
        delay(0.5)  
        G.E_MANAGER:add_event(Event({  
            trigger = 'after',  
            delay = 0.2,  
            func = function()  
                G.hand:unhighlight_all()  
                return true  
            end  
        }))  
    end,  
}