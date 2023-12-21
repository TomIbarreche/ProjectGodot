extends StaticBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animator = $AnimationPlayer
@export var bank_interior: Node2D
@onready var inventory = get_tree().get_first_node_in_group("inventory")
@onready var debug_area: DebuggableArea = $DebuggableArea

var isLock: bool = true
var player = null
signal enterBank(player: Player, spawn: Marker2D, tilemap: TileMap)

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	debug_area.debug = Callable(self, "_on_debug")

func _on_debug():
	DebugManager.toggle_visibility(true)
	DebugManager.gather_debuggable_object_information(self)
	
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
		await TransitionLayer.play_fade_to_black()
		enterBank.emit(Pplayer, bank_interior.spawn, bank_interior.interior)
		animator.play("doors_close")

func UnlockDoor():
	isLock= false
	interaction_area.action_name = "Enter"
	for slot in player.inventory.slots:
		if slot.item != null:
			if slot.item.name == "Bank Key":
				inventory.deleteSlotObj.emit(slot)
