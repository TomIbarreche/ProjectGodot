extends State
class_name PlayerUIState

func _ready():
	set_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)
	
func _exit_state() -> void:
	set_physics_process(false)


