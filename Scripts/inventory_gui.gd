extends Control
class_name InventoryGUI

var isOpen: bool = false
signal inventory_open
signal inventory_close
signal useSlotObj
signal deleteSlotObj
signal examineSlotObj

@onready var inventory: Inventory = preload("res://Inventory/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var itemNamePlaceholder: Label = $ItemName

var currentInventorySlot: InventorySlot
var currentSlot

func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
		
func order():
	inventory.slots.sort_custom(resourceFirst);
	update()
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].toggleFocusMode()
		
	if slots[0].slot_is_occupy:
		slots[0].grab_focus()
		currentSlot = slots[0]
		currentInventorySlot = inventory.slots[0]
		
func resourceFirst(a,b):
	if a.item != null:
		if b.item != null:
			if a.item.indexInInventory < b.item.indexInInventory:
				return true
			else:
				return false
		return true
	return false
	
func _ready():
	get_viewport().connect("gui_focus_changed",_on_focus_changed)
	inventory.inventory_updated.connect(update)
	update()
	close()
	
func open():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].toggleFocusMode()
	if slots[0].slot_is_occupy:
		slots[0].grab_focus()
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
		
	if currentSlot and currentSlot.slot_is_occupy == true and isOpen:
		if event.is_action_pressed("interact"):
			useSlotObj.emit(currentInventorySlot)
		elif event.is_action_pressed("Delete"):
			deleteSlotObj.emit(currentInventorySlot)
		elif event.is_action_pressed("Examine"):
			examineSlotObj.emit(currentInventorySlot)

func _on_focus_changed(control: Control):
	var index = 0
	if control != null:
		for slot in slots:
			if slot == control:
				currentInventorySlot = inventory.slots[index]
				currentSlot = slot
				itemNamePlaceholder.text = inventory.slots[index].item.name
			index += 1
