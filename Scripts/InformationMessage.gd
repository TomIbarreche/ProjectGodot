extends Control
class_name InformationMessage

@onready var label = $PanelContainer/Label
func _ready():
	close()
	
func close():
	visible = false

func open(message):
	label.text = message
	visible = true

