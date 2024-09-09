extends Node2D

@export var waterSpeed:int = 50

var sectionScenes = [preload("res://Level/sections/section_1.tscn"),
	preload("res://Level/sections/section_2.tscn"),
	preload("res://Level/sections/section_3.tscn")
]

var sectionNodes:Array = []

var lastSection

const UIOffset = Vector2(-576, -324)

signal end

func _ready(): #To begin, stack three sections.
	
	sectionNodes.append(place_section($firstPos.position))
	sectionNodes.append(place_section(sectionNodes[0].next_pos))
	sectionNodes.append(place_section(sectionNodes[1].next_pos))
	
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
	var node = sectionScenes.pick_random().instantiate()
	add_child(node)
	node.position = pos
	node.offscreen.connect(_on_section_offscreen)
	return node

func _on_section_offscreen(node):
	if node == sectionNodes[0]:
		sectionNodes.append(place_section(sectionNodes[-1].next_pos))
		sectionNodes.pop_front().queue_free() #Removes and deletes the first element, which is node.

func _on_water_entered(_body_rid, _body, _body_shape_index, _local_shape_index): #The player loses 
	$Anims.play("loss")

func main_menu():
	end.emit()
