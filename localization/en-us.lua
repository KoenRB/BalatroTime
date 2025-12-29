return {
  descriptions = {
    Back = {  
      b_pendulum = {  
        name = "Pendulum Deck",  
        text = {  
          "Start with {C:attention}2{} Pendulum Spectrals",  
          "Start with {C:attention}Hypersonic{} and",  
          "{C:attention}Crystal Ball{} vouchers"  
        }  
      }  
    },  
    Joker = {
      j_hourglass = {
        name = "Hourglass",
        text = {
          "Gains {C:chips}+1{} Chips",
          "every {C:attention}5{} seconds",
          "{C:inactive}(since bought){}",
          "Currently: {C:chips}+#1#{} Chips"
        }
      },
      j_rust = {
        name = "Rust",
        text = {
          "When scoring gain {C:mult}+#1#{} Mult",
          "reduced by 1 every {C:attention}15{} seconds"
        }
      },
      j_alarm_clock = {
        name = "Alarm Clock",
        text = {
          "{C:chips}+#1#{} chips and {C:mult}+#2#{} mult",
          "Destroyed in {C:attention}#3#{} seconds"
        }
      },
      j_freeze = {
        name = "Freeze",
        text = {
          "Gives the ability to pause time"
        }
      },
      j_engineer = {
        name = "Engineer",
        text = {
          "When sold or destroyed",
          "the {C:voucher}#1#{} voucher",
          "is added to the shop"
        }
      },
      j_chronos = {  
        name = "Chronos",  
        text = {  
          "{X:mult,C:white}X#1#{} Mult",  
          "Gains {C:mult}#2#{} Mult every",  
          "{C:attention}#3#{} seconds",  
          "Blesses joker to the right",  
          "every {C:attention}60{} seconds"  
        }        
      }  
    },
    Tarot = {
      c_pyre = {
        name = "Pyre",
        text = {
          "Convert up to {C:highlighted}#1#{} highlighted cards",
          "in your hand to {C:mult}Fire{}"
        }
      }
    },
    Enhanced  = {
      m_fire = {
        name = "Fire",
        text = {
          "{C:mult}+#1#{} Mult",
          "Decreases mult by 3 every",
          "{C:attention}30{} seconds"
        }
      }
    },
    Voucher = {
      v_hypersonic = {
        name = "Hypersonic",
        text = {
          "Adds {C:attention}#1#{} speed options"
        }
        },
      v_lightspeed = {
        name = "Lightspeed",
        text = {
          "Adds {C:attention}#1#{} speed options"
        }
      }
    },
    Spectral = {
      c_pendulum = {
        name = "Pendulum",
        text = {
          "Select 2 cards, ",
          "they randomly get a",
          "{G.C.green}Green Seal{} or {HEX(FF69B4)}Pink Seal{}}"
        }

      }
    },
    Stake = {  
      stake_blessed = {  
        name = "Blessed Stake",  
        text = {  
          "Shop can have {C:attention}Blessed{} Jokers",
          "{C:inactive,s:0.8}(Scales by 0.1 per minute)",
          "{C:inactive,s:0.8}(Cannot be to the left of a blessed sticker with higher Xmult)",
          "{s:0.8}Applies all previous Stakes"
        }
      } 
    },
    Other = {
      green_seal = {
        name = "Green Seal",
        text = {
          "Rewinds time by {C:attention}5sec{}",
          "on a scoring trigger"
        }
      },
      pink_seal = {
        name = "Pink Seal",
        text = {
          "Changes Rank of card",
          "to the leading digit",
          "on the global timer"
        }
      },
      blessed = {
        name = "Blessed",
        text = {
          "Card is {HEX(ADD8E6)}Blessed{}",
          "{C:mult}#1#x{}, gains 0.1 per min",
          "{C:inactive}capped at 5x{}"
        }
      }
    }
  },
  misc = {  
    challenge_names = {
      ["chronos_blessed"] = {  
        name = "Chronos's Blessing",  
        text = {  
           "Start with an eternal Chronos",  
            "Only {C:attention}4{} Joker slots",  
            "Only {C:attention}1{} Consumable slot"  
        }  
      } 
    },
    labels = {  
        ["pink_seal"] = "Pink Seal" ,
        ["green_seal"] = "Green Seal"
    }  
  }  
}

