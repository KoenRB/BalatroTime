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
end


function BalatroTime.update(dt)
  -- only tick during blinds
  if G.STAGE ~= G.STAGES.RUN then return end
  if BalatroTime.paused then return end

  local scaled_dt = dt * BalatroTime.speed
  BalatroTime.clock = BalatroTime.clock + scaled_dt

  -- update display
  BalatroTime.clock_disp = BalatroTime.format_time(BalatroTime.clock)

  -- accumulators
  BalatroTime._acc_5s  = BalatroTime._acc_5s  + scaled_dt
  BalatroTime._acc_30s = BalatroTime._acc_30s + scaled_dt
  BalatroTime._acc_60s = BalatroTime._acc_60s + scaled_dt

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

