class_name PlayerIdleState
extends State

@export var speed=300
const STATE_NAME = "IDLE"
signal is_moving
signal is_interacting

func _ready():
#	set_physics_process(false)
	pass
	
func _enter_state() -> void:
#	set_physics_process(true)
	player_animator.play("idle")
	is_active = true
	pass
	
func _exit_state() -> void:
	is_active = false
	pass

func _process(_delta):
	if is_active:
		handleInput()
		if player.is_interacting:
			is_interacting.emit()
		elif player.velocity != Vector2.ZERO:
			is_moving.emit()

func handleInput():
	var movedir = Input.get_vector("walk_left","walk_right", "walk_up", "walk_down").normalized()
	player.velocity = movedir * speed
