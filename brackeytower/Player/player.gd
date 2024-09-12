extends Node2D

@export var walkSpeed:int
@export var fallSpeed:int
@export var gravity:int
@export var jumpForce:int
@export var accel:int
@export var wallJumpForce:int
@export var flyForce:int #How effective holding up is when jumping upwards

@export var hasDoubleJump:bool = false
@export var hasWallJump:bool = false

var input:float #Unit vector representing player movement dir
var faceRight = false
var lastFaceRight = false
var grounded = true

signal moved
signal turnaround

func _ready():
	$"State Machine/idle".swap.connect(_on_first_swap)
	
	for node in $Audio.get_children():
		node.volume_db = Global.volume_db
	
	Global.gotDoubleJump.connect(_on_got_double_jump)
	Global.gotWallJump.connect(_on_got_wall_jump)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	input = 0
	
	#Read keyboard/controller. Accounts for weird input and > 1 controller tilt.
	input += Input.get_action_strength("move_right")
	input -= Input.get_action_strength("move_left")
	if input > 1:
		input = 1 #input is now ready to go!
	
	if input != 0: #Facing variable is unchanged if the player does not input
		if input > 0:
			faceRight = true
		elif input < 0:
			faceRight = false
	
	if lastFaceRight != faceRight: turnaround.emit(faceRight)
	
	lastFaceRight = faceRight

func _physics_process(_delta):
	pass

func _on_first_swap(_origin, _dest):
	moved.emit()
	$"State Machine/idle".swap.disconnect(_on_first_swap)

func is_on_right_wall():
	return $rightWallRay.is_colliding()

func is_on_left_wall():
	return $leftWallRay.is_colliding()

func _on_got_double_jump():
	hasDoubleJump = true

func _on_got_wall_jump():
	hasWallJump = true
