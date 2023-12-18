extends Control
class_name PauseMenu

signal pauseOn
signal pauseOff
var isOnPause = false

@onready var SaveBtn: Button = $VBoxContainer/SaveBtn
@onready var LoadBtn: Button = $VBoxContainer/LoadBtn


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
	SaveBtn.grab_focus()

func toggle_pauseMenu():
	if isOnPause:
		Hide()
	else:
		Open()
		
