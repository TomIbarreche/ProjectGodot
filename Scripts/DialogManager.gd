extends Node

@onready var text_box_scene = preload("res://Scenes/text box/text_box.tscn")

var dict = {}

func StartDialog(pnj: PNJ):
	ShowTextBox(pnj.global_position, pnj.lines, pnj)
	
func ShowTextBox(position: Vector2, dialog: Array[String], pnj: PNJ):
	var text_box = text_box_scene.instantiate()
	text_box.finished_displaying_dialog.connect(_on_text_box_finished_displaying)
	get_tree().get_first_node_in_group("UI").add_child(text_box)
	text_box.global_position = position
	text_box.DisplayText(dialog[pnj.current_line_index], pnj)
	dict[pnj] = text_box

func _on_text_box_finished_displaying(pnj:PNJ, text_box):
	text_box.queue_free()
	pnj.current_line_index += 1
	dict.erase(pnj)
	if pnj.current_line_index >= pnj.lines.size():
		pnj.current_line_index = 0
		return
	ShowTextBox(pnj.global_position, pnj.lines, pnj)
	
		
func _process(_delta):
	for value in dict:
		if dict[value] != null:
			dict[value].global_position.x = value.global_position.x - dict[value].size.x /2
			dict[value].global_position.y = value.global_position.y - 48
