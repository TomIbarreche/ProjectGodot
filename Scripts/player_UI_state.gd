extends State
class_name PlayerUIState

const STATE_NAME = "UI"

func _ready():
	pass
	
func _enter_state() -> void:
	player_animator.stop()
	player.velocity = Vector2.ZERO
	get_tree().paused = true
	
func _exit_state() -> void:
	get_tree().paused = false
