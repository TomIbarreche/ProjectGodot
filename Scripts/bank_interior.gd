extends Node2D

@onready var spawn: Marker2D = $InteriorSpawn
@onready var interior: TileMap = $TileMap
@onready var interaction_area: InteractionArea = $InteractionArea
@export var exterior_spawn: Marker2D
@export var exterior_tilemap: TileMap
@onready var lights: Array[Node] = $Lights.get_children()

signal exitBank(player: Player, spawn: Marker2D, exteriorTilemap: TileMap)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	_toggle_lights(false)
	

func _on_interact(player)-> void:
	exitBank.emit(player, exterior_spawn, exterior_tilemap)

func _toggle_lights(is_fusebox_active: bool) -> void:
	for light in lights:
		if !light.is_in_group("default_light"):
			var children = light.get_children()
			for child in children:
				if child is PointLight2D:# && !child.is_in_group("default_light"):
					child.visible = is_fusebox_active

func _on_fuse_box_activate_fuse_box(is_fusebox_active):
	_toggle_lights(is_fusebox_active)
