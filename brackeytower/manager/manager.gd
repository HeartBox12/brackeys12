extends Node

const levelScene = preload("res://Level/level.tscn")
const menuScene = preload("res://Menu/menu.tscn")

@onready var menuNode = $Menu
var levelNode = null

func _on_start():
	switch_to_game() #Function extracted for the purposes of animation foolishness

func _on_end():
	switch_to_menu()

#When changing from the menu to the game, USE THIS
func switch_to_game():
	menuNode.queue_free()
	
	levelNode = levelScene.instantiate()
	add_child(levelNode)
	levelNode.position = Vector2(0, 0)
	levelNode.end.connect(_on_end)
	
func switch_to_menu():
	levelNode.queue_free()
	
	menuNode = menuScene.instantiate()
	add_child(menuNode)
	menuNode.position = Vector2(0, 0)
	menuNode.start.connect(_on_start)
