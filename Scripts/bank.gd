extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animator = $AnimationPlayer
@export var spawn: Marker2D
@export var interiorTileMap: TileMap

signal enterBank

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact(player):
	animator.play("doors_open")
	await $AnimationPlayer.animation_finished
	enterBank.emit(player, spawn, interiorTileMap)
	animator.play("doors_close")
	
