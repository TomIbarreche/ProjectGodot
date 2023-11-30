extends Node2D


@onready var messagePanel = get_tree().get_first_node_in_group("message") as InformationMessage
@onready var choiceMessagePanel = get_tree().get_first_node_in_group("choiceMessage") as ChoiceMessage
var isMessageOpen = false
var isChoiceMessageOpen = false
var callableFunction
signal MessageOpen
signal MessageClose

func _ready():
	choiceMessagePanel.yesBtnPressed.connect(YesBtnPressed)
	choiceMessagePanel.noBtnPressed.connect(NoBtnPressed)

func ShowMessage(message: String):
	MessageOpen.emit()
	messagePanel.open(message)
	isMessageOpen = true

func ShowChoiceMessage(message: String, pCallableFunction: Callable):
	MessageOpen.emit()
	choiceMessagePanel.open(message)
	isChoiceMessageOpen = true
	callableFunction = pCallableFunction

func CloseMessage():
	isMessageOpen = false
	messagePanel.close()
	MessageClose.emit()

func CloseChoiceMessage():
	await get_tree().create_timer(0.1).timeout
	isChoiceMessageOpen = false
	MessageClose.emit()	
	
func IsMessageOpen():
	return isMessageOpen

func IsChoiceMessageOpen():
	return isChoiceMessageOpen
	
func YesBtnPressed():
	callableFunction.call()
	CloseChoiceMessage()
	
func NoBtnPressed():
	CloseChoiceMessage()
