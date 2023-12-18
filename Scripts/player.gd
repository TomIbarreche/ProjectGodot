extends CharacterBody2D
class_name Player

@export var inventory: Inventory
@onready var final_state_machine: FinalStateMachine = $FinalStateMachine
@export var speed:int = 300
@onready var player_Label_scene = preload("res://Scenes/player_label.tscn")
var label
var can_interact: bool = true
var is_interacting: bool = false
var is_debuging: bool = false

var is_debug_mode_on: bool =false

func _ready():
	InteractionManager.connect("area_near", toggle_label_visibility)
	final_state_machine.change_state($FinalStateMachine/PlayerStateManager/PlayerIdleState)
	
func _input(event):
	if event.is_action_pressed("interact") && self.final_state_machine.state.STATE_NAME != "INTERACT" && !is_debug_mode_on:
		if InteractionManager.active_interact_areas.size() > 0:
			is_interacting = true
			can_interact = false
			if InteractionManager.active_interact_areas[0].get_parent() is Collectable:
				await InteractionManager.active_interact_areas[0].interact.call(inventory)
				can_interact = true
				is_interacting = false
				label.queue_free()
			else:
				await InteractionManager.active_interact_areas[0].interact.call(self)
				can_interact = true
				is_interacting = false
	elif event.is_action_pressed("start_debug"):
		if label != null:
			label.queue_free()
		toggle_debug_mode()
	elif event.is_action_pressed("interact") && is_debug_mode_on && self.final_state_machine.state.STATE_NAME != "UI":
		if InteractionManager.active_debug_areas.size() > 0:
			DebugManager.is_debuging = true
			can_interact = false
			if label != null:
				label.queue_free()
				InteractionManager.active_debug_areas[0].debug.call()

func toggle_label_visibility(active_area: Area2D):
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

func toggle_debug_mode():
	is_debug_mode_on = !is_debug_mode_on
