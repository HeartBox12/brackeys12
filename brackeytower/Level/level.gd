extends Node2D

@export var waterSpeed:int = 0
@export var notLost:bool = true
@export var maxPlayerLead:int

var sectionScenes = [preload("res://Level/sections/section_1.tscn"),
	preload("res://Level/sections/section_2.tscn"),
	preload("res://Level/sections/section_3.tscn")
]

var doubleJumpSection = preload("res://Level/sections/dJump_section.tscn")
var wallJumpSection = preload("res://Level/sections/wJump_section.tscn")

var sectionNodes:Array = []
var sectionsPlaced:int = 0

signal end

func _ready(): #To begin, stack three sections.
	$music.volume_db = Global.volume_db
	$water/roar.volume_db = Global.volume_db
	
	Global.gotDoubleJump.connect(_on_double_jump_get)
	Global.gotWallJump.connect(_on_wall_jump_get)
	
	sectionNodes.append($startSection)
	sectionNodes.append(place_section(sectionNodes[0].next_pos))
	sectionNodes.append(place_section(sectionNodes[1].next_pos))
	
	$camera.position_smoothing_enabled = false
	$camera.position.y = $player.position.y
	$camera.position_smoothing_enabled = true
	
	$Canvas/Control.position = Vector2(0, 0) #Somehow starts the game somewhere else. I don't know why
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if notLost:
		$camera.position.y = $player.position.y
	
func _physics_process(delta):
	$water.position.y -= waterSpeed * delta
	if $water.position.y - $player.position.y > maxPlayerLead:
		$water.position.y = $player.position.y + maxPlayerLead

func place_section(pos): #The position determines the bottom center of the section.
	var node = null
	
	match sectionsPlaced: #Determines what section is assigned to node.
		1: node = doubleJumpSection.instantiate()
		2: node = wallJumpSection.instantiate()
		_: node = sectionScenes.pick_random().instantiate()
	add_child(node)
	node.position = pos
	node.offscreen.connect(_on_section_offscreen)
	sectionsPlaced += 1
	return node

func _on_section_offscreen(node):
	if node == sectionNodes[0]:
		sectionNodes.append(place_section(sectionNodes[-1].next_pos))
		sectionNodes.pop_front().queue_free() #Removes and deletes the first element, which is node.

func _on_water_entered(_body_rid, _body, _body_shape_index, _local_shape_index): #The player loses 
	$Anims.play("loss")

func main_menu():
	end.emit()

func _on_player_moved():
	$Anims.play("start")

func _on_double_jump_get():
	$Anims.play("DoubleJump")

func _on_wall_jump_get():
	$Anims.play("WallJump")
