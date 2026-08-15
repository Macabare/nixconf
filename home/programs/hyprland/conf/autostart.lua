local vars = require("conf/variables")

hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprland-session.target")
  hl.exec_cmd("vicinae server")  
  hl.exec_cmd("systemctl --user start wallpaper.service")
  -- hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  -- hl.exec_cmd("kbuildsycoca6")
  -- hl.exec_cmd("hyprsunset")
end)

hl.on("hyprland.shutdown", function()
  os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)