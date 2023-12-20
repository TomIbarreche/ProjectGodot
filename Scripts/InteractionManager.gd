extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")

signal area_near(area)

var active_interact_areas: Array[Node]= []
var active_debug_areas: Array[Node]= []

var is_interacting = false
var active_interact_area
var active_debug_area


func _process(_delta):
	if !player.is_debug_mode_on:
		active_debug_areas.clear()
		if active_interact_areas.size() > 0 && active_interact_area != active_interact_areas[0]:
			active_interact_area = active_interact_areas[0]
			active_interact_areas.sort_custom(_sort_by_distance_to_player)
			area_near.emit(active_interact_areas[0])
		elif active_interact_areas.size() <= 0:
			area_near.emit(null)
			active_interact_area = null
	else:
		active_interact_areas.clear()
		if active_debug_areas.size() > 0 && active_debug_area != active_debug_areas[0]:
			active_debug_area = active_debug_areas[0]
			active_debug_areas.sort_custom(_sort_by_distance_to_player)
			area_near.emit(active_debug_areas[0])
		elif active_debug_areas.size() <= 0:
			area_near.emit(null)
			active_debug_area = null
		
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
func register_area(area):
	if area is InteractionArea:
		active_interact_areas.push_back(area)
	else:
		active_debug_areas.push_back(area)
	
func unregister_area(area):
	if area is InteractionArea:
		var index = active_interact_areas.find(area)
		if index != -1:
			active_interact_areas.remove_at(index)
	else:
		var index = active_debug_areas.find(area)
		if index != -1:
			active_debug_areas.remove_at(index)
