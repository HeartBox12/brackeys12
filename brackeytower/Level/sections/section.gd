extends Node2D

func _on_screen_exited():
	queue_free()

func next_pos():
	return $nextSpot.global_position
