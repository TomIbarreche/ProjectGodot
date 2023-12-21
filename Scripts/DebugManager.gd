extends Node

@onready var debugUI: DebugUI = get_tree().get_first_node_in_group("debug_ui")
@onready var main_camera: Camera2D = get_tree().get_first_node_in_group("main_camera")
@onready var debug_camera_scene = preload("res://Scenes/debug_camera.tscn")
var debug_camera: Camera2D
var current_debug_area: DebuggableArea
var is_debug_function_triger: bool = false
var is_debuging = false
const DEBUG_FUNCTION_ACTIVE_STRING = "ACTIVE"
const DEBUG_FUNCTION_DIRECTION_STRING = "DIRECTION"
const DEBUG_FUNCTION_NAME_STRING = "FUNCTION_NAME"


func toggle_visibility(value: bool):
	debugUI.visible = value

func gather_pnj_informations(pnj: PNJ, current_thought: String) -> void:
	debugUI._fill_pnj_informations(pnj.debug_area, current_thought)
	current_debug_area = pnj.debug_area

func gather_debuggable_object_information(object: Node)-> void:
	debugUI._fill_object_informations(object.debug_area)
	current_debug_area = object.debug_area
	
func handle_debuggable_function(debug_function_button: Button, is_debug_function_button_on: bool) -> void:
	if is_debug_function_button_on:
		register_debuggable_function(debug_function_button.text)
	else:
		unregister_debuggable_function(debug_function_button.text)
		
func register_debuggable_function(debug_function_name) -> void:
	for debug_func in current_debug_area.debug_functions_dict:
		if debug_func[DEBUG_FUNCTION_NAME_STRING] == debug_function_name:
			debug_func[DEBUG_FUNCTION_ACTIVE_STRING] = true
	
func unregister_debuggable_function(debug_function_name) -> void:
	for debug_func in current_debug_area.debug_functions_dict:
		if debug_func[DEBUG_FUNCTION_NAME_STRING] == debug_function_name:
			debug_func[DEBUG_FUNCTION_ACTIVE_STRING] = false
	
func check_for_debuggable_functions(interaction_area: InteractionArea, pnj: PNJ):
	for debug_function in pnj.debug_area.debug_functions_dict:
		if debug_function[DEBUG_FUNCTION_NAME_STRING] == interaction_area.debug_function_name[DEBUG_FUNCTION_NAME_STRING]:
			if debug_function[DEBUG_FUNCTION_ACTIVE_STRING] == true:
				for direction in interaction_area.debug_function_name[DEBUG_FUNCTION_DIRECTION_STRING]:
					match direction:
						"RIGHT":
							if pnj.eye_direction.target_position.x > 0:
								print("Coming from right")
								current_debug_area = pnj.debug_area
								move_camera_for_debug()
								return 
						"UP":
							return
						"LEFT":
							if pnj.eye_direction.target_position.x < 0:
								print("Coming from left")
								current_debug_area = pnj.debug_area
								move_camera_for_debug()
								return 
	for debug_function in interaction_area.get_parent().debug_area.debug_functions_dict:
		if debug_function[DEBUG_FUNCTION_NAME_STRING] == interaction_area.debug_function_name[DEBUG_FUNCTION_NAME_STRING]:
			if debug_function[DEBUG_FUNCTION_ACTIVE_STRING] == true:
				for direction in interaction_area.debug_function_name[DEBUG_FUNCTION_DIRECTION_STRING]:
					match direction:
						"RIGHT":
							if pnj.eye_direction.target_position.x > 0:
								print("Coming from right")
								current_debug_area = pnj.debug_area
								move_camera_for_debug()
								return 
						"UP":
							return
						"DOWN":
							return
						"LEFT":
							if pnj.eye_direction.target_position.x < 0:
								print("Coming from left")
								current_debug_area = pnj.debug_area
								move_camera_for_debug()
								return 
func move_camera_for_debug():
	debug_camera = debug_camera_scene.instantiate()
	current_debug_area.get_parent().add_child(debug_camera)
	debug_camera.make_current()
	is_debug_function_triger = true

func leave_debug_mode():
	debug_camera.queue_free()
	is_debug_function_triger = false
	main_camera.make_current()
