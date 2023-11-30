extends Control
class_name ChoiceMessage

@onready var label = $Panel/VSplitContainer/Label
@onready var yesBtn = $Panel/VSplitContainer/HSplitContainer/YesBtn
@onready var noBtn = $Panel/VSplitContainer/HSplitContainer/NoBtn
signal yesBtnPressed
signal noBtnPressed


func _ready():
	close()
	
func close():
	visible = false

func open(message):
	label.text = message
	visible = true
	yesBtn.grab_focus()


func _on_yes_btn_pressed():
	yesBtnPressed.emit()
	close()


func _on_no_btn_pressed():
	noBtnPressed.emit()
	close()
	

func _input(event):
	if MessageManager.isChoiceMessageOpen:
		if event.is_action_pressed("interact") && yesBtn.has_focus():
			yesBtnPressed.emit()
			close()
		if event.is_action_pressed("interact") && noBtn.has_focus():
			noBtnPressed.emit()
			close()
