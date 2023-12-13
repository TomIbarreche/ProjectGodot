extends CharacterBody2D
class_name Player

@export var inventory: Inventory
var can_interact: bool = true
var is_interacting: bool = false
@onready var interaction_label: Label = $Label

func _ready():
	InteractionManager.connect("interactable_area_near", toggle_label_visibility)
	interaction_label.hide()
	
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
			else:
				await InteractionManager.active_areas[0].interact.call(self)
				can_interact = true
				is_interacting = false

func toggle_label_visibility(active_area: InteractionArea):
	if active_area:
		interaction_label.text = "[E] to " + active_area.action_name
		interaction_label.global_position = global_position
		interaction_label.global_position.y -= 40
		interaction_label.global_position.x -= interaction_label.size.x /2
		interaction_label.show()
	else:
		interaction_label.hide()
