
-- Green Seal: +5 seconds to round timer upon scoring
SMODS.Seal {  
    key = "Green",  
    atlas = "custom_seals",
    pos = {x = 1, y = 0},  -- Adjust position to match your sprite sheet  
    -- atlas = "your_atlas",  -- Replace with your atlas name  
    badge_colour = G.C.GREEN,  
    calculate = function(self, card, context)  
        if context.cardarea == G.play and (context.main_scoring or context.individual) then
            -- Add 5 seconds to timer  
            if BalatroTime then  
                BalatroTime.clock = BalatroTime.clock + 5  
                return {  
                    message = '+5s',  
                    colour = G.C.GREEN  
                }  
            end  
        end  
    end  
}

-- Pink seal
SMODS.Seal {          
    key = "Pink",  
    atlas = "custom_seals",      
    pos = {x = 0, y = 0},          
    badge_colour = HEX("FF69B4"),  
      
    calculate = function(self, card, context)    
        if context.hand_drawn and context.cardarea == G.hand then    
            return self:update_card_rank(card)  
        end  
    end,  
      
    update = function(self, card, dt)  
        if card.area == G.hand then  
            return self:update_card_rank(card)  
        end  
    end,  
      
    update_card_rank = function(self, card)  
        -- Get leading digit of current time    
        local time_string = BalatroTime.format_time(BalatroTime.clock)    
        local leading_digit  
        for char in time_string:gmatch(".") do    
            if char ~= "0" and char ~= ":" then    
                leading_digit = char    
                break    
            end    
        end  
          
        -- Check per-card state, not global seal state  
        if leading_digit and leading_digit ~= (card.ability.seal.current_leading_digit) then  
            -- Map digit to rank    
            local rank_map = {["1"]="Ace", ["2"]="2", ["3"]="3", ["4"]="4", ["5"]="5", ["6"]="6", ["7"]="7", ["8"]="8", ["9"]="9"}    
            local new_rank = rank_map[leading_digit] or "Ace"  
              
            -- Change the card's rank    
            SMODS.change_base(card, nil, new_rank)  
              
            -- Update per-card state  
            card.ability.seal.current_leading_digit = leading_digit  
            card.ability.seal.current_rank = new_rank  
              
            return {    
                message = new_rank,    
                colour = HEX("FF69B4")    
            }  
        end  
          
        return nil  
    end  
}