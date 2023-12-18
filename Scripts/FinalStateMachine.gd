class_name  FinalStateMachine
extends Node

@export var state: State

func change_state(newState: State):
	if state is State:
		state._exit_state()
		
	newState._enter_state()
	state = newState

func _process(_delta):
#	print("STATE ", state)
	pass
