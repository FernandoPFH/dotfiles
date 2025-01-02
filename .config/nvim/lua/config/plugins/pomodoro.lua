local showingPomoUI = false
local pomoTimer = nil
local sessionCurrentIndex = -1

local pomo = nil

local function get_pomo()
  if pomo == nil then
    pomo = require('pomo')
  end

  return pomo
end

local function get_session_config(session_name)
  local session = get_pomo().get_config().sessions[session_name]
  if not session then
    return
  end
  return session
end

local function start_session(current_session, index)
  if current_session == nil or index > #current_session then
    return
  end

  local timer_config = current_session[index]
  local time_limit = require("pomo.util").parse_time(timer_config.duration)
  if not time_limit then
    return
  end

  sessionCurrentIndex = index

  pomoTimer = get_pomo().start_timer(time_limit, {
    name = timer_config.name,
    timer_done = function()
      start_session(current_session, index + 1)
    end,
  })
end

local function hide_timer(seconds)
  showingPomoUI = true
  vim.loop.new_timer():start(
    seconds * 1000, 0,
    vim.schedule_wrap(function()
      get_pomo().hide_timer(pomoTimer)
      showingPomoUI = false
    end)
  )
end

return {
  {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = true,
    cmd = { 'TimerStart', 'TimerRepeat', 'TimerSession' },
    dependencies = {
      'rcarriga/nvim-notify'
    },
    opts = {
      sessions = {
        -- Example session configuration for a session called "pomodoro".
        pomodoro = {
          { name = "💼 Work", duration = "25m" },
          { name = "⚽ Short Break", duration = "5m" },
          { name = "💼 Work", duration = "25m" },
          { name = "⚽ Short Break", duration = "5m" },
          { name = "💼 Work", duration = "25m" },
          { name = "⚽ Long Break", duration = "15m" },
        },
      },
    },
    keys = {
      {
        '<space>ps',
        function()
          if pomoTimer == nil or get_pomo().get_timer(pomoTimer.id) == nil then
            start_session(get_session_config('pomodoro'), 1)
            hide_timer(2)
          elseif pomoTimer.paused then
            pomo.resume_timer(pomoTimer)
            hide_timer(1)
          else
            pomo.show_timer(pomoTimer)
            hide_timer(1)
          end
        end,
        desc = 'Pomodoro - Start/Resume Timer'
      },
      {
        '<space>pf',
        function()
          if pomoTimer ~= nil and get_pomo().get_timer(pomoTimer.id) ~= nil then
            if not pomoTimer.paused then
              pomo.pause_timer(pomoTimer)
              pomo.show_timer(pomoTimer)
              hide_timer(1)
            else
              pomo.stop_timer(pomoTimer)
              hide_timer(1)
            end
          end
        end,
        desc = 'Pomodoro - Pause/Stop Timer'
      },
      {
        '<space>pw',
        function()
          if pomoTimer == nil or get_pomo().get_timer(pomoTimer.id) == nil then
            return
          end

          if string.find(string.lower(pomoTimer.name), "work") then
            local sessionConfig = get_session_config('pomodoro')
            if sessionCurrentIndex == #sessionConfig then
              get_pomo().stop_timer(pomoTimer)
              require('notify')("Stopping session!", 'info', {
                title = "🍅 - Pomodoro Timer",
                timeout = 500
              })
            else
              get_pomo().stop_timer(pomoTimer)
              start_session(sessionConfig, sessionCurrentIndex + 1)
              hide_timer(2)
            end
          else
            require('notify')("Not on work!", 'error', {
              title = "🍅 - Pomodoro Timer",
              timeout = 500
            })
          end
        end,
        desc = 'Pomodoro - Skip Work'
      },
      {
        '<space>pb',
        function()
          if pomoTimer == nil or get_pomo().get_timer(pomoTimer.id) == nil then
            return
          end

          if string.find(string.lower(pomoTimer.name), "break") then
            local sessionConfig = get_session_config('pomodoro')
            if sessionCurrentIndex == #sessionConfig then
              get_pomo().stop_timer(pomoTimer)
              require('notify')("Stopping session!", 'info', {
                title = "🍅 - Pomodoro Timer",
                timeout = 500
              })
            else
              get_pomo().stop_timer(pomoTimer)
              start_session(sessionConfig, sessionCurrentIndex + 1)
              hide_timer(2)
            end
          else
            require('notify')("Not on break!", 'error', {
              title = "🍅 - Pomodoro Timer",
              timeout = 500
            })
          end
        end,
        desc = 'Pomodoro - Skip Break'
      },
      {
        '<space>pu',
        function()
          if pomoTimer == nil or get_pomo().get_timer(pomoTimer.id) == nil then
            return
          end

          if showingPomoUI then
            get_pomo().hide_timer(pomoTimer)
            showingPomoUI = false
          else
            get_pomo().show_timer(pomoTimer)
            showingPomoUI = true
          end
        end,
        desc = 'Pomodoro - Toggle UI'
      }
    }
  }
}
