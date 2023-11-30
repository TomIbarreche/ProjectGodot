extends Node
class_name FuseBox

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var inventory = get_tree().get_first_node_in_group("inventory")
var isUnplug = true
var player
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
		
func _on_interact(pPlayer: Player):
	if player == null:
		player = pPlayer
	if isUnplug:
		if player.inventory.CheckForItemInInventory("Fuse"):
			if !MessageManager.IsChoiceMessageOpen():
				MessageManager.ShowChoiceMessage("Insert your Fuse in the FuseBox ?", Callable(self, "UnlockDoor"))
		else:
			if !MessageManager.IsMessageOpen():
				MessageManager.ShowMessage("You need to find a Fuse")
			else:
				MessageManager.CloseMessage()

func UnlockDoor():
	isUnplug= false
	interaction_area.action_name = "Start"
	for slot in player.inventory.slots:
		if slot.item != null:
			if slot.item.name == "Fuse":
				inventory.deleteSlotObj.emit(slot)
