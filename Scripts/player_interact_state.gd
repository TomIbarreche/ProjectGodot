class_name PlayerInteractState
extends State

const STATE_NAME = "INTERACT"
signal is_moving
signal is_idle

func _ready():
	pass
	
func _enter_state() -> void:
	is_active = true
	player_animator.stop()
	pass
	
func _exit_state() -> void:
	is_active = false
	pass

func _process(_delta):
	if is_active:
		if player.velocity != Vector2.ZERO and player.is_interacting == false:
			is_moving.emit()
		elif player.velocity == Vector2.ZERO and player.is_interacting == false:
			is_idle.emit()
