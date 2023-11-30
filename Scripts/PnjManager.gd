extends Node

var pnjs: Array[Node] = []

func _ready():
	pnjs = get_tree().get_nodes_in_group("pnj")

func _input(event):
	if event.is_action_pressed("test"):
		for pnj in pnjs:
			DialogManager.StartDialog(pnj.global_position, pnj.lines, pnj, pnj.current_line_index)
