class_name PlayerIdleState
extends State

@export var player: Player
@export var animator: AnimationPlayer
@export var speed=0
const STATE_NAME = "IDLE"
signal is_moving
signal is_interacting

func _ready():
	set_physics_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)
	animator.play("idle")
	
func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	handleInput()
	if InteractionManager.is_interacting:
		is_interacting.emit()
	elif player.velocity != Vector2.ZERO:
		is_moving.emit()

func handleInput():
	var movedir = Input.get_vector("walk_left","walk_right", "walk_up", "walk_down").normalized()
	player.velocity = movedir * speed
