extends Node

const levelScene = preload("res://Level/level.tscn")
const menuScene = preload("res://Menu/menu.tscn")

@onready var menuNode = $Menu
var levelNode = null

func _on_start():
	menuNode.queue_free()
	
	levelNode = levelScene.instantiate()
	add_child(levelNode)
	levelNode.position = Vector2(0, 0)
	levelNode.end.connect(_on_end)

func _on_end():
	levelNode.queue_free()
	
	menuNode = menuScene.instantiate()
	add_child(menuNode)
	menuNode.position = Vector2(0, 0)
	menuNode.start.connect(_on_start)
