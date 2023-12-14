class_name PlayerInventoryState
extends State

const STATE_NAME = "INVENTORY"
func _ready():
	pass
	
func _enter_state() -> void:
	player_animator.stop()
	player.velocity = Vector2.ZERO
	get_tree().paused = true
	
func _exit_state() -> void:
	get_tree().paused = false
