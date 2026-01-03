SMODS.Enhancement {  
    key = 'fire',  
    atlas = "burned",
    pos = { x = 0, y = 0 },  
    config = {   
        mult = 15,   
        extra = {   
            last_updated = 0,   
            time_left = 0,   
            decay_time = 30,   
            decay_val = 3,  
            paused = false
        }   
    },
    loc_vars = function(self, info_queue, card)  
        return { vars = { card.ability.mult, card.ability.extra.time_left } }  
    end,
    update = function(self, card, dt)  
        -- Skip decay if paused  
        if card.ability.extra.paused then return end  
          
        local now = (BalatroTime and BalatroTime.clock) or 0  
        local last_updated = card.ability.extra.last_updated or 0  
        local elapsed = now - last_updated  
  
        card.ability.extra.time_left = math.max(0, card.ability.extra.decay_time - elapsed)  
        if card.ability.extra.time_left <= 0 then  
            card.ability.mult = card.ability.mult - card.ability.extra.decay_val  
            card.ability.extra.last_updated = now  
            card.ability.extra.time_left = card.ability.extra.decay_time  
            if card.ability.mult <= 0 then  
                card:remove()  
            end  
        end  
    end  
}