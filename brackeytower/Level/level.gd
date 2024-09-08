extends Node2D

@export var waterSpeed:int = 50

var sections = [preload("res://Level/sections/section_1.tscn"),
	preload("res://Level/sections/section_2.tscn"),
	preload("res://Level/sections/section_3.tscn")
]

var lastSection

const UIOffset = Vector2(-576, -324)

signal end

func _ready(): #To begin, stack three sections.
	
	lastSection = place_section($firstPos.position)
	lastSection = place_section(lastSection.next_pos())
	lastSection = place_section(lastSection.next_pos())
	
	$camera.position_smoothing_enabled = false
	$camera.position.y = $player.position.y
	$camera.position_smoothing_enabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$camera.position.y = $player.position.y
	$Control.set_position($camera.get_target_position() + UIOffset)

func _physics_process(delta):
	$water.position.y -= waterSpeed * delta

func place_section(pos): #The position determines the bottom center of the section.
	var node = sections.pick_random().instantiate()
	add_child(node)
	node.position = pos
	return node

func _on_water_entered(_body_rid, _body, _body_shape_index, _local_shape_index): #The player loses 
	$Anims.play("loss")

func main_menu():
	end.emit()
