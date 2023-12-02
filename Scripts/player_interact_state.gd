class_name PlayerInteractState
extends State

@export var player: Player
@export var animator: AnimationPlayer
const STATE_NAME = "INTERACT"
signal is_moving
signal is_idle


func _ready():
	set_physics_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)
	animator.stop()
	
func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	if player.velocity != Vector2.ZERO and InteractionManager.is_interacting == false:
		is_moving.emit()
	elif player.velocity == Vector2.ZERO and InteractionManager.is_interacting == false:
		is_idle.emit()
