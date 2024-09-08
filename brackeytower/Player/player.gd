extends Node2D

@export var walkSpeed:int
@export var gravity:int
@export var jumpForce:int

var input:int #Unit vector representing player movement dir
var faceRight = false
var grounded = true

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	input = 0
	
	#Read keyboard/controller. Accounts for weird input and < 1 controller tilt.
	input += Input.get_action_strength("move_right")
	input -= Input.get_action_strength("move_left")
	if input > 1:
		input = 1 #input is now ready to go!
	
	if input != 0: #Facing variable is unchanged if the player does not input
		if input > 0:
			faceRight = true
		elif input < 0:
			faceRight = false

func _physics_process(_delta):
	pass
