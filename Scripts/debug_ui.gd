extends CanvasLayer
class_name DebugUI

@onready var name_label: Label = $Control/PanelContainer/Control2/VBoxContainer/NameLabel
@onready var frame: TextureRect = $Control/PanelContainer/Control2/VBoxContainer/Frame
@onready var age_label: Label = $Control/PanelContainer/Control/VBoxContainer/BasicInformations/AgeLabel
@onready var pob_label: Label = $Control/PanelContainer/Control/VBoxContainer/BasicInformations/PobLabel
@onready var thought_label: Label = $Control/PanelContainer/Control/VBoxContainer/BasicInformations/ThoughtLabel
@onready var functions_grid_container: GridContainer = $Control/PanelContainer/Control/VBoxContainer/HBoxContainer2/GridContainer
@onready var debug_button_scene = preload("res://Scenes/debug_button.tscn")
@onready var basic_informations_panel: VBoxContainer = $Control/PanelContainer/Control/VBoxContainer/BasicInformations
const DEBUG_FUNCTION_ACTIVE_STRING = "ACTIVE"
const DEBUG_FUNCTION_FUNCTION_NAME_STRING = "FUNCTION_NAME"

func _fill_pnj_informations(debug_area: DebuggableArea, current_thought: String) -> void:
	name_label.text =  debug_area.NAME	
	age_label.text = age_label.text + " " + debug_area.age
	pob_label.text = pob_label.text + " " + debug_area.pob
	thought_label.text = thought_label.text + " "+ current_thought
	frame.texture = debug_area.frame
	for debug_function in debug_area.debug_functions_dict:
		_instantiate_debug_buttons(debug_function[DEBUG_FUNCTION_FUNCTION_NAME_STRING], debug_function[DEBUG_FUNCTION_ACTIVE_STRING] )
		
func _fill_object_informations(debug_area: DebuggableArea) -> void:
	basic_informations_panel.visible = false
	name_label.text =  debug_area.NAME
	frame.texture = debug_area.frame
	for debug_function in debug_area.debug_functions_dict:
		_instantiate_debug_buttons(debug_function[DEBUG_FUNCTION_FUNCTION_NAME_STRING], debug_function[DEBUG_FUNCTION_ACTIVE_STRING] )

func _instantiate_debug_buttons(debugable_function: String, is_active: bool):
	var debug_button = debug_button_scene.instantiate()
	functions_grid_container.add_child(debug_button)
	debug_button.text = debugable_function
	debug_button.grab_focus()
	debug_button.button_pressed = is_active

func _input(event):
	if event.is_action_pressed("Escape") && visible == true:
		for children in functions_grid_container.get_children():
			children.queue_free()
		basic_informations_panel.visible = true
		DebugManager.toggle_visibility(false)
		DebugManager.is_debuging = false
		
