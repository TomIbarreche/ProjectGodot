class_name PlayerMovingState
extends State

const STATE_NAME = "MOVING"
signal is_idle
signal is_interacting

func _ready():
	pass
	
func _enter_state() -> void:
	is_active = true
	pass
	
func _exit_state() -> void:
	is_active = false
	pass
	
func _process(_delta):
	if is_active:
		player.move_and_slide()
		if player.is_interacting:
			is_interacting.emit()
		elif player.velocity == Vector2.ZERO:
			is_idle.emit()
		else:
			handleInput()
			updateAnimations()
		
func handleInput():
	var movedir = Input.get_vector("walk_left","walk_right", "walk_up", "walk_down").normalized()
	player.velocity = movedir * player.speed
	
func updateAnimations():
	var direction = "down"
	
	if player.velocity.x < 0: 
		direction = "left"
	elif player.velocity.x > 0: 
		direction = "right"
	elif player.velocity.y < 0: 
		direction = "up"
	
	player_animator.play("walk_"+direction)
