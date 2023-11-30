extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

const MAX_WIDTH = 256

var text = ""

var letter_index = 0

@export var letter_time = 0.03
@export var space_time = 0.06
@export var punctuation_time = 1
var Pnj

signal finished_displaying_dialog
	
func DisplayText(text_to_display: String, pnj):
	Pnj = pnj
	text = text_to_display
	label.text = text_to_display

	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)

	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized #wait for x resize
		await resized #wait for y resize
		custom_minimum_size.y = size.y

	global_position.x -= size.x /2
	global_position.y -= size.y + 24

	label.text = ""
	DisplayLetter(Pnj)
	
func DisplayLetter(Pnj):
	label.text += text[letter_index]
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying_dialog.emit(Pnj, self)
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
		


func _on_letter_display_timer_timeout():
	DisplayLetter(Pnj)
