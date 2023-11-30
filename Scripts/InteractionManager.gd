extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var inventory: Inventory = preload("res://Inventory/playerInventory.tres")
@onready var label = $Label

const BASE_TEXT = "[E] to "

var active_areas = []
var can_interact = true
var is_interacting = false

func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = BASE_TEXT + active_areas[0].action_name
		label.global_position = player.global_position
		label.global_position.y -= 86
		label.global_position.x -= label.size.x /2
		label.show()
	else:
		label.hide()
		
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			is_interacting = true
			can_interact = false
			label.hide()
			if active_areas[0].get_parent() is Collectable:
				await active_areas[0].interact.call(inventory)
				can_interact = true
				is_interacting = false
			else:
				await active_areas[0].interact.call(player)
				can_interact = true
				is_interacting = false
