extends CanvasLayer

@onready var player_prompt: Node = $Player_prompt

func _process(_delta):
	if player_prompt.get_children().size() > 1:
		for p in player_prompt.get_children():
			player_prompt.get_child(0).queue_free()
