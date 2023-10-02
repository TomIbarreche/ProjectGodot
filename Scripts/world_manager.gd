extends Node

@onready var inventory = get_tree().get_first_node_in_group("inventory") as InventoryGUI

func _ready():
	inventory.inventory_open.connect(PauseGame)
	inventory.inventory_close.connect(UnPauseGame)
	

func PauseGame():
	#get_tree().paused = true
	
func UnPauseGame():
	#get_tree().paused = false
