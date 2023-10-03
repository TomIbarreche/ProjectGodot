extends Node2D

class_name Collectable

@onready var interaction_area: InteractionArea = $InteractionArea
@export var itemRes: InventoryItem

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
	
func _on_interact(inventory: Inventory):
	inventory.insert(itemRes)
	queue_free()

