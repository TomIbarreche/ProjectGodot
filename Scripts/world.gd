extends Node2D
signal player_in_building(is_player_in_building)
signal night_time(is_night_time)

var is_player_in_building: bool = false:
	get:
		return is_player_in_building
	set(value):
		is_player_in_building = value
		player_in_building.emit(is_player_in_building)

var is_night_time: bool = false:
	get: 
		return is_night_time
	set(value):
		is_night_time = value
		night_time.emit(is_night_time)
		
