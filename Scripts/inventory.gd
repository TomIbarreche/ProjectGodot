extends Resource

class_name Inventory

@export var slots: Array[InventorySlot]
signal inventory_updated

func insert(item: InventoryItem):
	for slot in slots:
		if slot.item == item:
			slot.amount += 1
			inventory_updated.emit()	
			return
	
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amount = 1
			slots[i].item.indexInInventory = i
			inventory_updated.emit()
			return
			

func CheckForItemInInventory(itemName: String):
	for slot in slots:
		if slot.item != null:
			if slot.item.name == itemName:
				return true
	return false
