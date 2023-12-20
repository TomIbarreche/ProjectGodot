extends Node2D

@export var destinationTileMap: TileMap
@export var spawn: Marker2D
signal border_reached
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var debug_area: DebuggableArea = $DebuggableArea

func _ready():
	debug_area.debug = Callable(self, "_on_debug")
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_debug():
	DebugManager.toggle_visibility(true)
	DebugManager.gather_debuggable_object_information(self)
	
func _on_interact(player):
	border_reached.emit(destinationTileMap, spawn, player)
	
