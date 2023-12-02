class_name PlayerInventoryState
extends State

@export var player: Player
@export var animator: AnimationPlayer
const STATE_NAME = "INVENTORY"
func _ready():
	set_process(false)
	
func _enter_state() -> void:
	animator.stop()
	player.velocity = Vector2.ZERO
	set_physics_process(true)
	
func _exit_state() -> void:
	set_physics_process(false)

