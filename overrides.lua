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

function BalatroTime.init()
  BalatroTime.clock = 0
  BalatroTime.speed = 1
  BalatroTime.paused = false
  BalatroTime.clock_disp = "00:00"

  -- accumulators for minute/second triggers
  BalatroTime._acc_5s = 0
  BalatroTime._acc_30s = 0
  BalatroTime._acc_60s = 0

  -- Adding the timer to the HUD
  if not BalatroTime._patched_hud then
    BalatroTime._patched_hud = true

    local old_hud = G.UIDEF.HUD
    function G.UIDEF.HUD(...)
      local def = old_hud(...)

      -- Add a small top-right overlay row.
      -- (We avoid touching the left-side nodes entirely.)
      table.insert(def.nodes, {
        n = G.UIT.R,
        config = {align=('cri'), offset = {x=-0.3,y=2.1},major = G.ROOM_ATTACH},
        nodes = {
          {
            n = G.UIT.C,
            config = { align = "tr", padding = 0.0, offset = { x = -0.4, y = 0.35 } },
            nodes = { BalatroTime.create_UIBox_Clock() }
          }
        }
      })

      return def
    end
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
  Game.clockHUD = UIBox{
    definition = BalatroTime.create_UIBox_Clock(),
    config = {align=('cri'), offset = {x=-0.3,y=2.1},major = G.ROOM_ATTACH}
  }
  
-- Testing cards

  local c = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_hourglass', 'hourglass')
  c:add_to_deck()
  G.jokers:emplace(c)

  local c = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_rust', 'rust')
  c:add_to_deck()
  G.jokers:emplace(c)

  local c = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_alarm_clock', 'alarm_clock')
  c:add_to_deck()
  G.jokers:emplace(c)

  -- add a pyre tarot to the deck
  SMODS.add_card({key ='c_pyre'})

  -- initialize game data clock for persistence
  G.GAME.balatro_time = G.GAME.balatro_time or { clock = 0 }
end


function BalatroTime.update(dt)
  -- only tick during blinds
  if G.STAGE ~= G.STAGES.RUN then return end
  if BalatroTime.paused then return end
  if G.SETTINGS and G.SETTINGS.paused then return end
  if G.STATE and G.STATES and (G.STATE ~= G.STATES.SELECTING_HAND)then
    return
  end

  local scaled_dt = dt * BalatroTime.speed
  BalatroTime.clock = BalatroTime.clock + scaled_dt
  G.GAME.balatro_time.clock = BalatroTime.clock

  -- update display
  BalatroTime.clock_disp = BalatroTime.format_time(BalatroTime.clock)
  

  -- accumulators
  BalatroTime._acc_1s  = (BalatroTime._acc_1s or 0)  + scaled_dt
  BalatroTime._acc_5s  = BalatroTime._acc_5s  + scaled_dt
  BalatroTime._acc_30s = BalatroTime._acc_30s + scaled_dt
  BalatroTime._acc_60s = BalatroTime._acc_60s + scaled_dt

  if BalatroTime._acc_1s >= 1 then
    BalatroTime._acc_1s = BalatroTime._acc_1s - 1
    -- trigger 1s effects
  end

  if BalatroTime._acc_5s >= 5 then
    BalatroTime._acc_5s = BalatroTime._acc_5s - 5
    -- trigger 5s effects
  end

  if BalatroTime._acc_30s >= 30 then
    BalatroTime._acc_30s = BalatroTime._acc_30s - 30
    -- trigger 30s effects
  end

  if BalatroTime._acc_60s >= 60 then
    BalatroTime._acc_60s = BalatroTime._acc_60s - 60
    -- trigger 1-minute effects
  end
end


function BalatroTime.create_UIBox_Clock()
	return {n=G.UIT.ROOT, config = {align = "cm", padding = 0.03, colour = G.C.UI.TRANSPARENT_DARK, r=0.1}, nodes={
		{n=G.UIT.R, config = {align = "cm", padding= 0.05, colour = G.C.DYN_UI.MAIN, r=0.1}, nodes={
			{n=G.UIT.R, config={align = "cm", colour = G.C.DYN_UI.BOSS_DARK, r=0.1, minw = 1.5, padding = 0.08}, nodes={
				{n=G.UIT.R, config={align = "cm", minh = 0.0}, nodes={}},
				{n=G.UIT.R, config={id = 'timer_right', align = "cm", padding = 0.05, minw = 1.45, emboss = 0.05, r = 0.1}, nodes={{n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = BalatroTime, ref_value = 'clock_disp'}}, colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.4, pop_in = 0.5, maxw = 5, silent = true}), id = 'timer'}}
              }},
        -- {n=G.UIT.O, config={
        --   object = DynaText({
        --     string={{ref_table=BalatroTime, ref_value='debug_disp'}},
        --     colours={G.C.RED},
        --     scale=0.3,
        --     silent=true
        --   })
        -- }}
				},
			}}
		}}
	}}}
end
