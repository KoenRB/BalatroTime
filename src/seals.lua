
-- Green Seal: +5 seconds to round timer upon scoring
SMODS.Seal {  
    key = "Green",  
    pos = {x = 0, y = 0},  -- Adjust position to match your sprite sheet  
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

-- Pink Seal: Changes rank of card to the leading digit of current time before scoring
SMODS.Seal {        
    key = "Pink",       
    pos = {x = 1, y = 0},        
    badge_colour = HEX("FF69B4"),  
    calculate = function(self, card, context)        
        if context.before and context.cardarea == G.play then        
            -- Get leading digit of current time        
            local time_string = BalatroTime.format_time(BalatroTime.clock)  
            local leading_digit  
            for char in time_string:gmatch(".") do  
                if char ~= "0" and char ~= ":" then  
                    leading_digit = char  
                    break  
                end  
            end

  
            -- Map digit to rank (0 to 10, 1-9 to A-9)      
            local rank_map = {["0"]="10", ["1"]="A", ["2"]="2", ["3"]="3", ["4"]="4", ["5"]="5", ["6"]="6", ["7"]="7", ["8"]="8", ["9"]="9"}  
            local new_rank = rank_map[leading_digit] or "A"  
                    
            -- Change the card's rank using SMODS.change_base      
            SMODS.change_base(card, nil, new_rank)        
                    
            return {        
                message = new_rank,        
                colour = HEX("FF69B4")     
            }        
        end        
    end        
}
