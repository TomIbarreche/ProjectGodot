extends CharacterBody2D

var isMoving = false

@onready var animator = $AnimationPlayer 

func _physics_process(delta):
	if isMoving == false:
		animator.play("idle")
