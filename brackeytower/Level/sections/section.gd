extends Node2D

var onScreen:bool = false
signal offscreen

var next_pos:Vector2:
	get: #Getter function. Defines what happens when the variable is referenced.
		return $nextSpot.global_position

func _on_screen_entered():
	onScreen = true


func _on_screen_exited():
	offscreen.emit(self)
