extends CharacterBody2D
class_name Player

@export var inventory: Inventory
var can_interact: bool = true
var is_interacting: bool = false
@onready var interaction_label: Label = $Label
@onready var final_state_machine: FinalStateMachine = $FinalStateMachine
@export var speed:int = 300
@onready var player_Label_scene = preload("res://Scenes/player_label.tscn")
var label
var area
func _ready():
	InteractionManager.connect("interactable_area_near", toggle_label_visibility)
	interaction_label.hide()
	final_state_machine.change_state($FinalStateMachine/PlayerStateManager/PlayerIdleState)
	
func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if InteractionManager.active_areas.size() > 0:
			is_interacting = true
			can_interact = false
			interaction_label.hide()
			if InteractionManager.active_areas[0].get_parent() is Collectable:
				await InteractionManager.active_areas[0].interact.call(inventory)
				can_interact = true
				is_interacting = false
				label.queue_free()
			else:
				await InteractionManager.active_areas[0].interact.call(self)
				can_interact = true
				is_interacting = false

func toggle_label_visibility(active_area: InteractionArea):
	if active_area == null:
		if label != null:
			label.queue_free()
	if active_area :
		label = player_Label_scene.instantiate()
		get_tree().get_first_node_in_group("UI").get_child(0).add_child(label)
		label.global_position = global_position
		label.global_position.y -= 20
		label.global_position.x -= label.size.x /2
		label.text += active_area.action_name
