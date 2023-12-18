extends CheckButton

func _on_toggled(button_pressed):
	DebugManager.handle_debuggable_function(self, button_pressed)
