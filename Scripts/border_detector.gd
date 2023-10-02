extends Node2D

@export var destinationTileMap: TileMap
@export var spawn: Marker2D
signal borderReached
@onready var interaction_area: InteractionArea = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact(player):
	borderReached.emit(destinationTileMap, spawn, player)
	
