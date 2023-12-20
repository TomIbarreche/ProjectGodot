class_name PlayerIdleState
extends State

@export var speed=300
const STATE_NAME = "IDLE"
signal is_moving
signal is_interacting
signal is_debuging
signal is_debug_function_trigger

func _ready():
	pass
	
func _enter_state() -> void:
	player_animator.play("idle")
	is_active = true
	
func _exit_state() -> void:
	is_active = false

func _process(_delta):
	if is_active:
		handleInput()
		if player.is_interacting:
			is_interacting.emit()
		elif DebugManager.is_debuging:
			is_debuging.emit()
		elif player.velocity != Vector2.ZERO:
			is_moving.emit()
		elif DebugManager.is_debug_function_triger:
			is_debug_function_trigger.emit()

func handleInput():
	var movedir = Input.get_vector("walk_left","walk_right", "walk_up", "walk_down").normalized()
	player.velocity = movedir * speed
