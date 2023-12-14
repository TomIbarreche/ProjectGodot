extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

signal interactable_area_near(interactable_area)

var active_areas = []
var is_interacting = false
var active_area
func _process(_delta):
	if active_areas.size() > 0 && active_area != active_areas[0]:
		active_area = active_areas[0]
		active_areas.sort_custom(_sort_by_distance_to_player)
		interactable_area_near.emit(active_areas[0])
	elif active_areas.size() <= 0:
		interactable_area_near.emit(null)
		active_area = null
		
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)
