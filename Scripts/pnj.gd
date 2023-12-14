extends CharacterBody2D
class_name PNJ

@export var speed = 50
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animator = $AnimationPlayer

var startPosition
var endPosition
var current_line_index = 0

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
	
func _process(_delta):
	updateVelocity()
	move_and_slide()
	updateAnimation()
