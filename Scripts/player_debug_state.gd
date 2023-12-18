extends State
class_name PlayerDebugState

const STATE_NAME: String = "Debug"
signal is_idle

func _ready():
	pass
	
func _enter_state() -> void:
	is_active = true
	get_tree().paused = true
#
func _exit_state() -> void:
	is_active = false
	get_tree().paused = false

func _input(event):
	if is_active:
		if event.is_action_pressed("Escape"):
			DebugManager.leave_debug_mode()
			is_idle.emit()
