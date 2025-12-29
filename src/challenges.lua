SMODS.Challenge {  
    key = "chronos_blessed",  
    loc_txt = {  
        name = "Chronos's Blessing",  
        text = {  
            "Start with an eternal Chronos",  
            "Only {C:attention}4{} Joker slots",  
            "Only {C:attention}1{} Consumable slot"  
        }  
    },  
    rules = {  
        modifiers = {  
            {id = "joker_slots", value = 4},  
            {id = "consumable_slots", value = 1},
            {id = "hands", value = 2}
        }  
    },  
    jokers = {  
        {id = "j_chronos", eternal = true}  
    },  
    unlocked = function(self) return true end  
}