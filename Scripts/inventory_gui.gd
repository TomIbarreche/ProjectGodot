extends Control
class_name InventoryGUI

var isOpen: bool = false
signal inventory_open
signal inventory_close

@onready var inventory: Inventory = preload("res://Inventory/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
		
func _ready():
	inventory.inventory_updated.connect(update)
	update()
	close()
	
func open():
	visible = true
	isOpen = true
	inventory_open.emit()
	get_tree().paused = true
	
func close():
	visible = false
	isOpen = false
	inventory_close.emit()
	get_tree().paused = false
	

func toggle_inventory():
	if isOpen:
		close()
	else:
		open()

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		toggle_inventory()
