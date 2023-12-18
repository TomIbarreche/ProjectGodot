extends Node

@onready var debugUI: DebugUI = get_tree().get_first_node_in_group("debug_ui")
@onready var debug_camera: Camera2D = get_tree().get_first_node_in_group("debug_camera")
@onready var main_camera: Camera2D = get_tree().get_first_node_in_group("main_camera")


var is_debuging: bool = false
var registered_debuggable_functions_list: Array[String] = []
var current_pnj: PNJ
var is_debug_function_triger: bool = false

func toggle_visibility(value: bool):
	debugUI.visible = value

func gather_pnj_informations(pnj: PNJ, current_thought: String) -> void:
	debugUI._fill_pnj_informations(pnj, current_thought)
	current_pnj = pnj

func handle_debuggable_function(debug_function_button: Button, is_debug_function_button_on: bool) -> void:
	if is_debug_function_button_on:
		register_debuggable_function(debug_function_button.text)
	else:
		unregister_debuggable_function(debug_function_button.text)
		
func register_debuggable_function(debug_function_name) -> void:
	registered_debuggable_functions_list.push_back(debug_function_name)
	current_pnj.debug_functions_dict[debug_function_name] = true
	
func unregister_debuggable_function(debug_function_name) -> void:
	current_pnj.debug_functions_dict[debug_function_name] = false
	
func check_for_debuggable_functions_in_PNJ(pnj: PNJ, debug_function_name: String):
	for debug_function in pnj.debug_functions_dict:
		if debug_function == debug_function_name && pnj.debug_functions_dict[debug_function] == true:
			current_pnj = pnj
			move_camera_for_debug()
		
func move_camera_for_debug():
	debug_camera.global_position = current_pnj.global_position
	debug_camera.make_current()
	is_debug_function_triger = true

func leave_debug_mode():
	is_debug_function_triger = false
	main_camera.make_current()
