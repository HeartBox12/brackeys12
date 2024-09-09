extends AnimatedSprite2D

func open():
	play("power")

func _on_animation_finished():
	play("on")
