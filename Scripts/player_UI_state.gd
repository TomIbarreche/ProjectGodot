extends State
class_name PlayerUIState

const STATE_NAME = "UI"
signal is_idle

func _ready():
	pass
	
func _enter_state() -> void:
	is_active = true
	player_animator.stop()
	player.velocity = Vector2.ZERO
	get_tree().paused = true
	
func _exit_state() -> void:
	is_active = false
	get_tree().paused = false

func _process(_delta):
	if is_active:
		if DebugManager.is_debuging == false && !MessageManager.isMessageOpen && !MessageManager.isChoiceMessageOpen:
			is_idle.emit()
