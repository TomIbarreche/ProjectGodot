extends CharacterBody2D
class_name PNJ

@export var speed = 50
@export var limit = 0.5
#@export var endPoint: Marker2D
@export var lines: Array[String]
#@export var paths: Array[Curve2D]
#var current_path: int =0

@onready var animator = $AnimationPlayer
@onready var eye_direction: RayCast2D = $RayCast2D
@onready var debug_area: DebuggableArea = $DebuggableArea
@onready var path_follow: PathFollow2D = $".."
#@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
var startPosition
var endPosition
var current_line_index = 0
var current_thought: int = 0

	
func _ready():
	debug_area.debug = Callable(self, "_on_debug")
	startPosition = position
#	if paths.size() > 0:
#		print(paths[0])
#		path2D.curve = paths[0]
	
func _on_debug():
	DebugManager.toggle_visibility(true)
	DebugManager.gather_pnj_informations(self, debug_area.thought[current_thought])
	
	
	
func updateAnimation():
	var animationString = "walkUp"
	
	if velocity.x < 0: 
		animationString = "walkLeft"
	elif velocity.x > 0: 
		animationString = "walkRight"
	elif velocity.y < 0: 
		animationString = "walkUp"
	elif velocity.y > 0:
		animationString ="walkDown"
	animator.play(animationString)
	
func _process(delta):
	var old_pos = global_position
	path_follow.progress += delta * 50
	var direction = global_position - old_pos
	velocity = direction
	updateAnimation()
	eye_direction.target_position = Vector2(velocity.x * 180, velocity.y * 180)
