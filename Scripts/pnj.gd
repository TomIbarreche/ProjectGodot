extends CharacterBody2D
class_name PNJ

@export var speed = 50
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animator = $AnimationPlayer

var startPosition
var endPosition

@export var lines: Array[String]

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
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
	
func _physics_process(delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()

func _input(event):
	if event.is_action_pressed("test"):
		print("start dialog")
		DialogManager.StartDialog(global_position, lines, self)
		
