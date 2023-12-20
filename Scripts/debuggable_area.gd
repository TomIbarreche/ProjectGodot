extends Area2D
class_name DebuggableArea

var action_name: String = "Debug"
@export var NAME: String
@export var age: String
@export var pob: String
@export var thought: Array[String]
@export var frame: Texture2D
@export var debug_functions_dict = []

var debug: Callable = func():
	pass

func _on_body_entered(_body):
	InteractionManager.register_area(self)

func _on_body_exited(_body):
	InteractionManager.unregister_area(self)
