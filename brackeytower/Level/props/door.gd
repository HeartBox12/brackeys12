extends StaticBody2D

func _ready():
	$sound.volume_db = Global.volume_db

func open():
	$sprite.play("open")
	$sound.play()

func _on_animation_finished():
	collision_layer = 0
	collision_mask = 0
