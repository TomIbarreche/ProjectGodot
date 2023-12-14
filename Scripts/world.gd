extends Node2D
signal player_in_building(is_player_in_building)

var is_player_in_building: bool = false:
	get:
		return is_player_in_building
	set(value):
		is_player_in_building = value
		player_in_building.emit(is_player_in_building)
