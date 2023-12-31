extends Area2D

class_name InteractionArea

@export var action_name: String = "interact"
@export var debug_function_name = {}

var interact: Callable = func():
	pass


func _on_body_entered(body):
	if body is Player:
		InteractionManager.register_area(self)
	else:
		DebugManager.check_for_debuggable_functions(self , body)
		pass

func _on_body_exited(_body):
	InteractionManager.unregister_area(self)
