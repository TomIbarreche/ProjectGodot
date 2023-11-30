extends Node

@onready var text_box_scene = preload("res://Scenes/text box/text_box.tscn")

func StartDialog(position: Vector2, lines: Array[String], pnj: PNJ):
	ShowTextBox(position, lines, pnj, pnj.current_line_index)
	
func ShowTextBox(position: Vector2, dialog: Array[String], pnj: PNJ, currentLineIndex):
	var text_box = text_box_scene.instantiate()
	text_box.finished_displaying_dialog.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = position
#	text_box.DisplayText(dialog[currentLineIndex], pnj)
	text_box.DisplayText(dialog[pnj.current_line_index], pnj)

func _on_text_box_finished_displaying(pnj:PNJ, dialog: Array[String], position: Vector2, text_box):
	text_box.queue_free()
	pnj.current_line_index += 1
	if pnj.current_line_index >= dialog.size():
		pnj.current_line_index = 0
		return
	ShowTextBox(position, dialog, pnj, pnj.current_line_index)
	
		
func _process(delta):
#	if target != null && text_box != null:
#		text_box.global_position.y = target.global_position.y - 48
#		text_box.global_position.x = target.global_position.x -60
	pass
		
