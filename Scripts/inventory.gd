extends Resource

class_name Inventory

@export var items: Array[InventoryItem]
signal inventory_updated

func insert(item: InventoryItem):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			break
			
	inventory_updated.emit()
