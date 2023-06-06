-- Variables
local keys = {}

local mod = 'Mod4'
local tags = 5
keys.tags = tags

-- Keybindings
keys.globalkeys = gears.table.join(
  -- Awesome
  awful.key({mod}, 'c', awesome.restart),
  awful.key({mod, 'Shift'}, 'r', function() dashboard.toggle() end),

  --Hardware ( Laptop Users )
  awful.key({}, 'XF86MonBrightnessUp', function() awful.spawn.with_shell('dunster brightness_up') end),
  awful.key({}, 'XF86MonBrightnessDown', function() awful.spawn.with_shell('dunster brightness_down') end),
  awful.key({}, 'XF86AudioRaiseVolume', function() awful.spawn.with_shell('dunster volume_up') end),
  awful.key({}, 'XF86AudioLowerVolume', function() awful.spawn.with_shell('dunster volume_down') end),
  awful.key({}, 'XF86AudioMute', function() awful.spawn.with_shell('dunster volume_mute') end),
  awful.key({}, 'XF86AudioPlay', function() awful.spawn.with_shell('playerctl play-pause') end),
  awful.key({}, 'XF86AudioPrev', function() awful.spawn.with_shell('playerctl previous') end),
  awful.key({}, 'XF86AudioNext', function() awful.spawn.with_shell('playerctl next') end),

  -- Window management
  awful.key({'Mod1'}, 'Tab', function() awful.client.focus.byidx(1) end),
  awful.key({mod}, 'Right', function () awful.tag.incmwfact(0.025) end),
  awful.key({mod}, 'Left', function () awful.tag.incmwfact(-0.025) end),
  awful.key({mod}, 'Up', function () awful.client.incwfact(0.05) end),
  awful.key({mod}, 'Down', function () awful.client.incwfact(-0.05) end),

  -- Applications
  awful.key({mod}, 'Return', function() awful.util.spawn('alacritty') end),
  awful.key({mod}, 'd', function() awful.util.spawn('rofi -show drun') end),
  awful.key({mod}, 'r', function() awful.util.spawn('dmenu_run -p "RUN:"') end),

  -- Screenshots
  awful.key({}, 'Print', function() awful.util.spawn('shot') end),
  awful.key({'Shift'}, 'Print', function() awful.util.spawn('clip') end),
  awful.key({mod, 'Shift'}, 'Print', function() awful.util.spawn('clip') end)
)

-- Keyboard Control
keys.clientkeys = gears.table.join(
  awful.key({mod}, 'q', function(c) c:kill() end),
  awful.key({mod}, 'm', function(c) c.minimized = true end),
  awful.key({mod}, 'space', function(c) c.fullscreen = not c.fullscreen; c:raise() end),
  awful.key({mod}, 'Tab', function() awful.client.floating.toggle() end),
  awful.key({mod}, "t", function () awful.layout.inc(1) end)
)

-- Mouse controls
keys.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c) client.focus = c end),
  awful.button({mod}, 1, function() awful.mouse.client.move() end),
  awful.button({mod}, 2, function(c) c:kill() end),
  awful.button({mod}, 3, function() awful.mouse.client.resize() end)
)

for i = 1, tags do
  keys.globalkeys = gears.table.join(keys.globalkeys,

  -- View tag
  awful.key({mod}, '#'..i + 9,
    function ()
      local tag = awful.screen.focused().tags[i]
      if tag then
         tag:view_only()
      end
    end),

  -- Move window to tag
  awful.key({mod, 'Shift'}, '#'..i + 9,
    function ()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
     end
    end))
end

-- Set globalkeys
root.keys(keys.globalkeys)

return keys
