extends CanvasLayer
class_name DebugUI

@onready var name_label: Label = $Control/PanelContainer/Control2/VBoxContainer/NameLabel
@onready var frame: TextureRect = $Control/PanelContainer/Control2/VBoxContainer/Frame
@onready var age_label: Label = $Control/PanelContainer/Control/VBoxContainer/HBoxContainer/AgeLabel
@onready var pob_label: Label = $Control/PanelContainer/Control/VBoxContainer/HBoxContainer/PobLabel
@onready var thought_label: Label = $Control/PanelContainer/Control/VBoxContainer/HBoxContainer/ThoughtLabel
@onready var functions_grid_container: GridContainer = $Control/PanelContainer/Control/VBoxContainer/HBoxContainer2/GridContainer
@onready var debug_button_scene = preload("res://Scenes/debug_button.tscn")

func _fill_pnj_informations(pnj: PNJ, current_thought: String) -> void:
	name_label.text =  pnj.NAME	
	age_label.text = age_label.text + " " + pnj.age
	pob_label.text = pob_label.text + " " + pnj.pob
	thought_label.text = thought_label.text + " "+ current_thought
	frame.texture = pnj.frame
	for debug_function in pnj.debug_functions_dict:
		_instantiate_debug_buttons(debug_function, pnj.debug_functions_dict[debug_function])
	
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
		DebugManager.toggle_visibility(false)
		DebugManager.is_debuging = false
		
