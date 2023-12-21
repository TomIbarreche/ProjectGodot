extends CanvasLayer

func play_fade_to_black() -> void:
	$AnimationPlayer.play("fade_to_black")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play_backwards("fade_to_black")
