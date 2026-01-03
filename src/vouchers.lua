BalatroTime = BalatroTime or {}

-- Hypersonic: allows changing speed to 2x
SMODS.Voucher {
    key = 'hypersonic',
    atlas = "vouchers",
    pos = { x = 0, y = 0 },
    config = { extra = { speed_options = { 1, 2 } } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.speed_options } }
    end,
    redeem = function(self, card)
        BalatroTime.speed_options = card.ability.extra.speed_options
        return true
    end
}

-- Lightspeed: adds 4x speed option
SMODS.Voucher {
    key = 'lightspeed',
    atlas = "vouchers", 
    pos = { x = 0, y = 1 },
    config = { extra = { speed_options = { 1, 2, 4 } } },
    requires = { 'v_hypersonic' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.speed_options } }
    end,
    redeem = function(self, card)
        BalatroTime.speed_options = card.ability.extra.speed_options

        -- Update all copies of engineer 
        local remaining_copies = SMODS.find_card("j_engineer")  
        for _, joker in ipairs(remaining_copies) do  
          if G.GAME.used_vouchers[joker.ability.extra.next_voucher] then  
            joker.ability.extra.next_voucher = "v_lightspeed"  
          end  
        end
        return true
    end
}