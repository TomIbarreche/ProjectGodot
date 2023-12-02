extends Control
class_name PauseMenu

signal pauseOn
signal pauseOff
var isOnPause = false
func _ready():
	Hide()

func Hide():
	visible = false
	pauseOff.emit()
	isOnPause = false

func Open():
	visible = true
	pauseOn.emit()
	isOnPause = true

func toggle_pauseMenu():
	if isOnPause:
		Hide()
	else:
		Open()
		
func _input(event):
	if event.is_action_pressed("Pause"):
		toggle_pauseMenu()

