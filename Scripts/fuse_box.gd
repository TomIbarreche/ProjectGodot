extends Node
class_name FuseBox

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var inventory = get_tree().get_first_node_in_group("inventory")
var isUnplug = true
var player
var is_activate: bool = false
const ACTIVATE_ACTION_TEXt: String = "Activate"
const DEACTIVATE_ACTION_TEXt: String = "Deactivate"


signal activate_fuse_box(activate:bool)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
		
func _on_interact(pPlayer: Player):
	if player == null:
		player = pPlayer
	if isUnplug:
		if player.inventory.CheckForItemInInventory("Fuse"):
			if !MessageManager.IsChoiceMessageOpen():
				MessageManager.ShowChoiceMessage("Insert your Fuse in the FuseBox ?", Callable(self, "unlock_fusebox"))
		else:
			if !MessageManager.IsMessageOpen():
				MessageManager.ShowMessage("You need to find a Fuse")
			else:
				MessageManager.CloseMessage()
	else:
		is_activate = !is_activate
		activate_fuse_box.emit(is_activate)
		if is_activate:
			interaction_area.action_name = DEACTIVATE_ACTION_TEXt
		else:
			interaction_area.action_name = ACTIVATE_ACTION_TEXt

func unlock_fusebox() ->void:
	isUnplug= false
	interaction_area.action_name = ACTIVATE_ACTION_TEXt
	for slot in player.inventory.slots:
		if slot.item != null:
			if slot.item.name == "Fuse":
				inventory.deleteSlotObj.emit(slot)
