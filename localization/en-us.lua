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
      j_robin_hood = {  
        name = "Robin Hood",  
        text = {  
          "Converts {C:attention}#1#%{} of chips to Mult",  
          "Gains {C:attention}#3#%{} per {C:attention}#2#{} seconds",  
          "in current round"  
        }  
      },
      j_extinguisher = {
        name = "Extinguisher",
        text = {
          "Stops decay on all",
          "{C:attention}Fire{} enhanced cards"
        }
      },  
      j_fuse = {  
        name = "Fuse",  
        text = {  
          "In {C:attention}#1#{} seconds,",  
          "destroys {C:attention}#2#{} random",  
          "cards from hand, then",  
          "destroys itself"  
        }  
      },
      j_sundial = {
        name = "Sundial",
        text = {
          "Retriggers cards with {C:attention} rank{}",
          "equal to the {C:attention} leading digit{} on the clock",
          "{C:attention}#1#{} times"

        }
      },
      j_wormhole = {  
        name = "Wormhole",  
        text = {  
          "If time is less than {C:attention}#1#{} seconds,",  
          "fills consumable slots with",  
          "planet cards for played hand"  
        }
      },
      j_fertilizer = {
        name = "Fertilizer",
        text = {
          "Gain {C:attention}#1#{} interest cap",
          "{C:inactive} increases by 1 every minute{}"
        }
      },
      j_angel = {
        name = "Angel",
        text = {
          "Creates a {C:spectral}Pendulum{} card",
          "if hand played with {C:attention}3 3s{} on the clock"
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
          "Select {C:attention}2{} cards, ",
          "they randomly get a",
          "{C:green}Green Seal{} or {HEX(ff69b4)}Pink Seal{}"
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
          "{X:mult,C:white}X#1#{}, gains 0.1 per min",
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

