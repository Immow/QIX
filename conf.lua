function love.conf(t)
	t.title = "QIX Game"
	t.identity = "QIX Game"
	t.version = "11.4"
	t.console = true
	t.window.width = 800
	t.window.height = 800
	t.window.msaa = 8
	t.modules.joystick = false
	t.modules.physics = false
	t.externalstorage = true
	t.window.vsync = 0
	t.window.resizable = false
end