extends Node

@onready var text_box_scene = preload("res://Scenes/text box/text_box.tscn")

var dialog_lines: Array[String] = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false
var target: PNJ

func StartDialog(position: Vector2, lines: Array[String], pnj: PNJ):
	target = pnj
	if is_dialog_active:
		return
	
	dialog_lines = lines
	text_box_position = position
	ShowTextBox()
	
	is_dialog_active = true
	
func ShowTextBox():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying_dialog.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.DisplayText(dialog_lines[current_line_index])
	can_advance_line = false

func _on_text_box_finished_displaying():
	can_advance_line = true
	text_box.queue_free()
	current_line_index += 1
	if current_line_index >= dialog_lines.size():
		is_dialog_active = false
		current_line_index = 0
		return
	
	ShowTextBox()
	
func _unhandled_input(event):
#	if (event.is_action_pressed("interact") && is_dialog_active && can_advance_line):
#		text_box.queue_free()
#		current_line_index += 1
#		if current_line_index >= dialog_lines.size():
#			is_dialog_active = false
#			current_line_index = 0
#			return
#
#		ShowTextBox()
	pass
		
func _process(delta):
	if target != null && text_box != null:
		text_box.global_position.y = target.global_position.y - 48
		text_box.global_position.x = target.global_position.x -60
		
