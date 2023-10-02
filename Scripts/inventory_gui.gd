extends Control
class_name InventoryGUI

var isOpen: bool = false
signal inventory_open
signal inventory_close

func _ready():
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
