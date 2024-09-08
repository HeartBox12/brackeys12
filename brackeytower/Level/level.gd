extends Node2D

var sections = [preload("res://Level/sections/section_1.tscn"),
	preload("res://Level/sections/section_2.tscn"),
	preload("res://Level/sections/section_3.tscn")
]

var lastSection

func _ready(): #To begin, stack three sections.
	
	lastSection = place_section($firstPos.position)
	lastSection = place_section(lastSection.next_pos())
	lastSection = place_section(lastSection.next_pos())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func place_section(pos): #The position determines the bottom center of the section.
	var node = sections.pick_random().instantiate()
	add_child(node)
	node.position = pos
	return node #why not?
