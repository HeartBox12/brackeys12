extends Area2D

func grabbed():
	$sprite.play("pickup")
	Global.gotDoubleJump.emit()

func _on_animation_finished(): #So we can have a delay.
	queue_free()
