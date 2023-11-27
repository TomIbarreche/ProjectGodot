extends Panel

@onready var backgroundSprite: Sprite2D = $Background
@onready var itemSprite: Sprite2D = $CenterContainer/Panel/ItemSprite
@onready var amountLabel: Label = $CenterContainer/Panel/Label
var slot_is_occupy = false
@onready var inventory = get_tree().get_first_node_in_group("inventory") as InventoryGUI


func update(slot: InventorySlot):
	
	if !slot.item:
		backgroundSprite.frame = 0
		itemSprite.visible = false
		amountLabel.visible = false
		slot_is_occupy = false
	else:
		print("Index ", slot.item.indexInInventory)
		backgroundSprite.frame = 1
		itemSprite.visible = true
		itemSprite.texture = slot.item.textureInInventory
		amountLabel.visible = true
		slot_is_occupy = true
		if slot.amount > 1:
			amountLabel.text = str(slot.amount)
		else:
			amountLabel.visible = false
			
		
func _process(delta):
	if has_focus() and slot_is_occupy:  
		modulate = "74ffff"
	else:
		modulate = "ffffff"	

func _useSlotObject(inventorySlot):
	
	match inventorySlot.item.name:
		"BankKey":
			print("use bankkey")
		"Scroll":
			print("use Scroll")
		"Coin":
			print("use coin")
	inventorySlot.amount = inventorySlot.amount -1
	if inventorySlot.amount < 1:
		inventorySlot.item = null
		inventory.order()
	else:
		inventory.update()
	
		
	
func _deleteSlotObject(inventorySlot):
	inventorySlot.amount = inventorySlot.amount -1
	if inventorySlot.amount < 1:
		inventorySlot.item = null
	update(inventorySlot)
	inventory.order() 

func _examineSlotObject(inventorySlot):
	print("examine ", inventorySlot.item.name)
	
func toggleFocusMode():
	if !slot_is_occupy:
		self.set_focus_mode(Control.FOCUS_NONE)
	else:
		self.set_focus_mode(Control.FOCUS_ALL)
