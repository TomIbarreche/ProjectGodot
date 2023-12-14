class_name State
extends Node

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var player_animator: AnimationPlayer = player.get_child(1)
var is_active: bool = false
func _enter_state() -> void:
	pass
	
func _exit_state() -> void:
	pass


