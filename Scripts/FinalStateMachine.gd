class_name  FinalStateMachine
extends Node

@export var state: State


func _ready():
	change_state(state)
	
func change_state(newState: State):
	if state is State:
		state._exit_state()
		
	newState._enter_state()
	state = newState

func _process(delta):
#	print(state)
	pass
