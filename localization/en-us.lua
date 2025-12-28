return {
  descriptions = {
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
      }
    }
  },
  misc = {  
    labels = {  
        ["pink_seal"] = "Pink Seal" ,
        ["green_seal"] = "Green Seal"
    }  
  }  
}

