extends Node

@onready var final_state_machine =  $".." as FinalStateMachine
@onready var player_moving_state = $PlayerMovingState as PlayerMovingState
@onready var player_idle_state = $PlayerIdleState as PlayerIdleState
@onready var player_interact_state = $PlayerInteractState as PlayerInteractState
@onready var player_inventory_state =  $PlayerInventoryState as PlayerInventoryState
@onready var player_UI_state = $PlayerUIState as PlayerUIState
@onready var player_debug_state = $PlayerDebugState as PlayerDebugState
@onready var inventory = get_tree().get_first_node_in_group("inventory") as InventoryGUI


func _ready():
	player_moving_state.is_idle.connect(final_state_machine.change_state.bind(player_idle_state))
	player_moving_state.is_interacting.connect(final_state_machine.change_state.bind(player_interact_state))
	player_moving_state.is_debug_function_trigger.connect(final_state_machine.change_state.bind(player_debug_state))

	player_idle_state.is_moving.connect(final_state_machine.change_state.bind(player_moving_state))
	player_idle_state.is_interacting.connect(final_state_machine.change_state.bind(player_interact_state))
	player_idle_state.is_debuging.connect(final_state_machine.change_state.bind(player_UI_state))
	player_idle_state.is_debug_function_trigger.connect(final_state_machine.change_state.bind(player_debug_state))
	
	player_interact_state.is_moving.connect(final_state_machine.change_state.bind(player_moving_state))
	player_interact_state.is_idle.connect(final_state_machine.change_state.bind(player_idle_state))
	
	player_debug_state.is_idle.connect(final_state_machine.change_state.bind(player_idle_state))

	player_UI_state.is_idle.connect(final_state_machine.change_state.bind(player_idle_state))
	
	inventory.inventory_open.connect(final_state_machine.change_state.bind(player_inventory_state))
	inventory.inventory_close.connect(final_state_machine.change_state.bind(player_idle_state))

	MessageManager.MessageOpen.connect(final_state_machine.change_state.bind(player_UI_state))
	MessageManager.MessageClose.connect(final_state_machine.change_state.bind(player_idle_state))
