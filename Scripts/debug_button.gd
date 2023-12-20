extends CheckButton

func _on_pressed():
	DebugManager.handle_debuggable_function(self, button_pressed)
