extends CharacterBody2D
class_name PNJ

@export var speed = 50
@export var limit = 0.5
@export var endPoint: Marker2D
@export var NAME: String
@export var age: String
@export var pob: String
@export var thought: Array[String]
@export var frame: Texture2D
@export var debug_functions_dict = {}
		
@onready var animator = $AnimationPlayer

var startPosition
var endPosition
var current_line_index = 0
var current_thought: int = 0

@export var lines: Array[String]
@onready var debug_area: DebuggableArea = $DebuggableArea
	
func _ready():
	debug_area.debug = Callable(self, "_on_debug")
	startPosition = position
	endPosition = endPoint.global_position
	
func _on_debug():
	print("coin")
	DebugManager.toggle_visibility(true)
	DebugManager.gather_pnj_informations(self, thought[current_thought])
	
func updateVelocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit:
		position = endPosition
		changeDirection()
	velocity = moveDirection.normalized() * speed
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateAnimation():
	var animationString = "walkUp"
	
	if velocity.x < 0: 
		animationString = "walkLeft"
	elif velocity.x > 0: 
		animationString = "walkRight"
	elif velocity.y < 0: 
		animationString = "walkUp"
	
	animator.play(animationString)
	
func _process(_delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
