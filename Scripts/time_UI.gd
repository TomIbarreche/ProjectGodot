extends Control

@onready var canvas_modulate = $"../../CanvasModulate"

func _ready():
	canvas_modulate.time_tick.connect(_display_time)

func _display_time(day:int, hour:int, minute:int) -> void:
#	print("DAY ", day)
#	print("HOUR ", hour)
#	print("MINUTE ", minute)
	pass
