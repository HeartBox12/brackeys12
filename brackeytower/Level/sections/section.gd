extends Node2D

var onScreen:bool = false
signal offscreen

@onready var buttonVecs = $Tiles.get_used_cells_by_id(3)

var next_pos:Vector2:
	get: #Getter function. Defines what happens when the variable is referenced.
		return $nextSpot.global_position

func _ready():
	pass

func _on_screen_entered():
	onScreen = true

func _on_screen_exited():
	offscreen.emit(self)

func _on_button_pressed():
	for node in $cableInstances.get_children():
		node.open()
