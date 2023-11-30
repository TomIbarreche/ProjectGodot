extends Node2D
class_name Sign

@onready var interaction_area: InteractionArea = $InteractionArea
@export var message: String

func _ready():
	interaction_area.interact = Callable(self, "interact")
	
func interact(player: Player):
	if !MessageManager.IsMessageOpen():
		MessageManager.ShowMessage(message)
	else:
		MessageManager.CloseMessage()
