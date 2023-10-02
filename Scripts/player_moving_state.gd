class_name PlayerMovingState
extends State

@export var player: Player
@export var animator: AnimationPlayer
@export var speed=0

signal is_idle
signal is_interacting

func _ready():
	set_physics_process(false)
	
func _enter_state() -> void:
	set_physics_process(true)

	
func _exit_state() -> void:
	set_physics_process(false)	
	pass
	
func _physics_process(delta):
	player.move_and_slide()
	if InteractionManager.is_interacting:
		is_interacting.emit()
	elif player.velocity == Vector2.ZERO:
		is_idle.emit()
	else:
		handleInput()
		updateAnimations()
		
func handleInput():
	var movedir = Input.get_vector("walk_left","walk_right", "walk_up", "walk_down").normalized()
	player.velocity = movedir * speed
	
func updateAnimations():
	var direction = "down"
	
	if player.velocity.x < 0: 
		direction = "left"
	elif player.velocity.x > 0: 
		direction = "right"
	elif player.velocity.y < 0: 
		direction = "up"
	
	animator.play("walk_"+direction)
	
