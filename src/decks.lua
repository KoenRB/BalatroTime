-- Pendulum Deck
SMODS.Back {  
    key = "pendulum",  
    atlas = "burned",
    pos = { x = 0, y = 1 },  
    config = {  
        extra = {   
            consumables = {"c_pendulum", "c_pendulum"},   
            vouchers = {"v_hypersonic", "v_crystal_ball"}  
        }  
    },  
    apply = function(self)  
        -- Add vouchers directly to bought pool  
        for _, voucher_key in ipairs(self.config.extra.vouchers) do  
            G.GAME.used_vouchers[voucher_key] = true  
        end

        -- Apply the consumables
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(self.config.extra.consumables) do
                    SMODS.add_card({ key = v })
                end
                return true
            end
        }))
    end  
}

--

