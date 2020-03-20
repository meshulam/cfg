hs.hotkey.bind({"ctrl", "alt"}, "r", nil, function(e)
    print("Reloading Hammerspoon Config")
    hs.reload()
end)

-- Window positioning hotkeys
hs.loadSpoon("WindowHalfsAndThirds")
spoon.WindowHalfsAndThirds:bindHotkeys({
  left_half = { {"ctrl", "alt"}, "Left" },
  right_half = { {"ctrl", "alt"}, "Right" },
  max_toggle = { {"ctrl", "alt"}, "Up" },
})

--
-- hs.urlevent.setDefaultHandler("https", "org.hammerspoon.Hammerspoon")

-- require('./scroll_with_button_pressed')


-- hs.hints.style = "vimperator"
-- local logKeys = false
-- hs.hotkey.bind({"ctrl", "alt"}, "k", nil, function(e)
--     hs.hints.windowHints()
-- end)

-- see http://www.hammerspoon.org/docs/hs.eventtap.event.html#types
local logEvents = {
  -- hs.eventtap.event.types.NSApplicationDefined,
  -- hs.eventtap.event.types.NSEventTypeGesture,
}

batteryAlertLevels = { 20, 10 }

lastBatteryLevel = 100
hs.battery.watcher.new(function()
  local batteryLevel = hs.battery.percentage()

  for i = 1, #batteryAlertLevels do
    local alert = batteryAlertLevels[i]
    if batteryLevel < alert and lastBatteryLevel >= alert then
      local message = "Battery dropped below " .. alert .. "%"
      hs.notify.new({title="Hammerspoon", informativeText=message}):send()
    end
  end

  lastBatteryLevel = batteryLevel
end):start()

hs.eventtap.new(logEvents, function(e)
  print("got event")
  local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
  print("pressed mouse" .. pressedMouseButton)
end):start()
