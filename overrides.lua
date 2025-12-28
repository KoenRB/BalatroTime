BalatroTime = BalatroTime or {}

-- Store original Game.update ONCE
if not BalatroTime.Game_update_ref then
  BalatroTime.Game_update_ref = Game.update
end

-- Override Game.update
function Game:update(dt)
  BalatroTime.Game_update_ref(self, dt)
  BalatroTime.update(dt)
end

----------------------------------------------
------------MOD CODE -------------------------

local function add_mod_cards_to_deck()
  -- For testing purposes, add one of each mod card to the deck at start of run
  local c = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_hourglass', 'hourglass')
  c:add_to_deck()
  G.jokers:emplace(c)

  local c = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_rust', 'rust')
  c:add_to_deck()
  G.jokers:emplace(c)

  local c = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_alarm_clock', 'alarm_clock')
  c:add_to_deck()
  G.jokers:emplace(c)

  local c = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_freeze', 'freeze')
  c:add_to_deck()
  G.jokers:emplace(c)

  local c = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_engineer', 'engineer')
  c:add_to_deck()
  G.jokers:emplace(c)
  local c = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_engineer', 'engineer')
  c:add_to_deck()
  G.jokers:emplace(c)

  -- add consumables to the deck
  SMODS.add_card({key ='c_pyre'})
  SMODS.add_card({key ='c_pendulum'})
end

function BalatroTime.init()
  BalatroTime.clock = 0
  BalatroTime.speed = 1
  BalatroTime.speed_options = { 1 }
  BalatroTime.speed_text = "1x"
  BalatroTime.pause_available = false
  BalatroTime.paused = false
  BalatroTime.paused_text = "|>"

  BalatroTime.clock_disp = "00:00"

  -- accumulators for minute/second triggers
  BalatroTime._acc_5s = 0
  BalatroTime._acc_30s = 0
  BalatroTime._acc_60s = 0

  -- Functions for buttons
  G.FUNCS.pause_time = function()
    if not BalatroTime.pause_available then return end
    BalatroTime.paused = not BalatroTime.paused
    if BalatroTime.paused then
      BalatroTime.paused_text = "||"
    else
      BalatroTime.paused_text = "|>"
    end
  end

  G.FUNCS.update_speed = function()
    -- go to the next speed option
    local current_index = 1
    for i, v in ipairs(BalatroTime.speed_options) do
      if v == BalatroTime.speed then
        current_index = i
        break
      end
    end
    local next_index = current_index + 1
    if next_index > #BalatroTime.speed_options then
      next_index = 1
    end
    BalatroTime.speed = BalatroTime.speed_options[next_index]
    BalatroTime.speed_text = tostring(BalatroTime.speed) .. "x"
  end
end

function BalatroTime.format_time(seconds)
  local total_seconds = math.floor(seconds or 0)
  local mins = math.floor(total_seconds / 60)
  local secs = total_seconds % 60
  return string.format("%02d:%02d", mins, secs)
end


-- Override Game.start_run
BalatroTime.Game_start_run_ref = Game.start_run
function Game:start_run(args)  
  BalatroTime.Game_start_run_ref(self,args)  
  local saveTable = args.savetext or nil  
    
  -- Only reset clock for new runs (no saveTable)  
  if not saveTable then  
    BalatroTime.clock = 0  
  elseif saveTable.balatro_time and saveTable.balatro_time.clock then  
    -- Restore clock from save  
    BalatroTime.clock = saveTable.balatro_time.clock  
  end  
  Game.clockHUD = UIBox{
    definition = BalatroTime.create_UIBox_Clock(),
    config = {align=('cri'), offset = {x=-0.3,y=-0.5},major = G.ROOM_ATTACH}
  }
  
  
-- Testing cards

  -- add_mod_cards_to_deck()

  -- initialize game data clock for persistence
  G.GAME.balatro_time = G.GAME.balatro_time or { clock = 0 }
end


function BalatroTime.update(dt)
  -- Always update display (remove all the early returns)  
  if G.STAGE ~= G.STAGES.RUN then return end  
  
  -- update display
  BalatroTime.clock_disp = BalatroTime.format_time(BalatroTime.clock)
  
  -- Only increment time when conditions are met  
  if not BalatroTime.paused   
    and not (G.SETTINGS and G.SETTINGS.paused)   
    and G.STATE and G.STATES   
    and (G.STATE == G.STATES.SELECTING_HAND) then  
        -- Increment time here  
        local scaled_dt = dt * BalatroTime.speed
        BalatroTime.clock = BalatroTime.clock + scaled_dt
        G.GAME.balatro_time.clock = BalatroTime.clock
    end
end


function BalatroTime.create_UIBox_Clock()
	return {n=G.UIT.ROOT, config = {align = "cm", padding = 0.03, colour = G.C.UI.TRANSPARENT_DARK, r=0.1, minw = 3}, nodes={
		{n=G.UIT.R, config = {align = "cm", padding= 0.05, colour = G.C.DYN_UI.MAIN, r=0.1, minw = 3}, nodes={
			{n=G.UIT.R, config={align = "cm", colour = G.C.DYN_UI.BOSS_DARK, r=0.1, minw = 1.5, padding = 0.08}, nodes={
				{n=G.UIT.R, config={align = "cm", minh = 0.0}, nodes={}},
				{n=G.UIT.C, config={id = 'timer_right', align = "cm", padding = 0.05, minw = 1.45, emboss = 0.05, r = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm"}, nodes={
              -- Shows the time buttons available: 
              -- pause on the left(non-toggleable until BalatroTime.paused is true)
              -- speed, moves through the options in BalatroTime.speed_options on the right (<value>x)
              {
                n = G.UIT.C,
                config = {
                  align = "cm",
                  minw = 1.5,
                  padding = 0.1,
                  r = 0.1,
                  colour = G.C.DYN_UI.BOSS_DARK,
                  button = "pause_time",
                  hover = true,
                  shadow = true
                },
                nodes = {
                  {
                    n = G.UIT.T,
                    config = {
                      ref_table = BalatroTime,
                      ref_value = "paused_text",
                      scale = 0.5,
                      colour = G.C.UI.TEXT_LIGHT
                    }
                  }
                }
              },
              {  
                n = G.UIT.C,  
                config = {  
                    align = "cm",  
                    minw = 1.5,  
                    padding = 0.1,  
                    r = 0.1,  
                    colour = G.C.DYN_UI.BOSS_DARK,  
                    button = "update_speed",  
                    hover = true,  
                    shadow = true  
                },  
                nodes = {  
                    {  
                        n = G.UIT.T,  
                        config = {  
                            ref_table = BalatroTime,  
                            ref_value = "speed_text",  
                            scale = 0.5,  
                            colour = G.C.UI.TEXT_LIGHT  
                        }  
                    }  
                }  
              }  
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = BalatroTime, ref_value = 'clock_disp'}}, colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.4, pop_in = 0.5, maxw = 5, silent = true}), id = 'timer'}}
            }
          },
          }},
				}
			}}
		}}
	}
end
