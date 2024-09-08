extends Node2D

var onScreen:bool = false

func _on_screen_entered():
	onScreen = true


func _on_screen_exited():
	if onScreen:
		queue_free()

func next_pos():
	return $nextSpot.global_position
