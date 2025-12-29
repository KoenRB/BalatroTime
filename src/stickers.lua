-- Blessed sticker: 0.1xmult gained every minute, capped at 5x. forces blessed cards with higher xmult to be to its right
SMODS.Sticker {  
    key = "blessed",  
    badge_colour = HEX('add8e6'),  
    pos = { x = 2, y = 0 },  
    should_apply = function(self, card, center, area, bypass_roll)    
        if center.set == 'Joker' then    
            -- Check if Blessed Stake is active (sets blessed_odds)  
            local odds = G.GAME.starting_params.blessed_odds or 0  
          
            self.last_roll = pseudorandom((area == G.pack_cards and 'packssj' or 'shopssj')..self.key..G.GAME.round_resets.ante)    
            return (bypass_roll ~= nil) and bypass_roll or self.last_roll > (1-odds)    
        end    
        return false    
    end,
      
    apply = function(self, card, val)  
        card.ability[self.key] = {  
            xmult = 1.0,  
            start_time = BalatroTime.clock,  
            inc_sec = 60  
        }  
    end,  

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability[self.key].xmult } }
    end,
      
    calculate = function(self, card, context)  
        if context.joker_main then  
            local minutes_passed = math.floor((BalatroTime.clock - card.ability[self.key].start_time) / card.ability[self.key].inc_sec)  
            local xmult = math.min(1.0 + (minutes_passed * 0.1), 5.0)  
            card.ability[self.key].xmult = xmult  -- Update stored value  
            return { Xmult = xmult }  
        end  
    end,  
      
    -- Add sorting enforcement  
    card_sort = function(self, a, b)  
        -- Get blessed xmult values  
        local a_xmult = a.ability[self.key] and a.ability[self.key].xmult or 0  
        local b_xmult = b.ability[self.key] and b.ability[self.key].xmult or 0  
          
        -- Sort by blessed xmult (lower values first, so higher values end up right)  
        if a_xmult ~= b_xmult then  
            return a_xmult < b_xmult  
        end  
          
        -- Fallback to default sorting  
        return a.T.x + a.T.w/2 < b.T.x + b.T.w/2  
    end  
}