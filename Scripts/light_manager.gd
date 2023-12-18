extends Node
const EXTERIOR_LIGHT = "exterior_light"
@onready var lights: Array[Node] = get_tree().get_nodes_in_group(EXTERIOR_LIGHT)

func _ready():
	World.night_time.connect(toggle_exterior_light)
	toggle_exterior_light(false)
	
func toggle_exterior_light(is_night_time):
	for light in lights:
		var children = light.get_children()
		for child in children:
			if child is PointLight2D:
				child.visible = is_night_time
