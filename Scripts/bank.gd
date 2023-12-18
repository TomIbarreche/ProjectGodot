extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animator = $AnimationPlayer
@export var bank_interior: Node2D
@onready var inventory = get_tree().get_first_node_in_group("inventory")

var isLock: bool = true
var player = null
signal enterBank(player: Player, spawn: Marker2D, tilemap: TileMap)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact(Pplayer):
	if player == null:
		player = Pplayer
	if isLock:
		if player.inventory.CheckForItemInInventory("Bank Key"):
			if !MessageManager.IsChoiceMessageOpen():
				MessageManager.ShowChoiceMessage("Unlock door with Bank Key ?", Callable(self, "UnlockDoor"))
		else:
			if !MessageManager.IsMessageOpen():
				MessageManager.ShowMessage("The door is lock")
			else:
				MessageManager.CloseMessage()
		
	else:
		animator.play("doors_open")
		await $AnimationPlayer.animation_finished
		enterBank.emit(Pplayer, bank_interior.spawn, bank_interior.interior)
		animator.play("doors_close")

func UnlockDoor():
	isLock= false
	interaction_area.action_name = "Enter"
	for slot in player.inventory.slots:
		if slot.item != null:
			if slot.item.name == "Bank Key":
				inventory.deleteSlotObj.emit(slot)
