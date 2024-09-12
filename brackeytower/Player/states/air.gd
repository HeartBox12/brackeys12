extends State
@export var host:Node
@export var machine:Node
@export var sprite:Node
@export var cooldown:Node

var playerPos


func enter(): #When this state is entered
	pass
	
func exit(): #Just before this state is exited
	pass

func update(_delta): #Equivalent to func process(delta) in the host. Only use process() to call this
	if host.faceRight:
		sprite.play("air_right")
	else:
		sprite.play("air_left")

func physics_update(delta): #Equivalent to func physics_process() in the host.
	
	if host.is_on_floor(): #No longer in the air
		if host.input == 0:
			swap.emit(self, "idle")
			return
		else:
			swap.emit(self, "walk")
			return
	
	if host.is_on_right_wall() and cooldown.is_stopped() and host.input > 0 and host.hasWallJump:
		host.faceRight = false
		swap.emit(self, "wall_left")
		return
		
	if host.is_on_left_wall() and cooldown.is_stopped() and host.input < 0 and host.hasWallJump:
		host.faceRight = true
		swap.emit(self, "wall_right")
		return
	
	if Input.is_action_just_pressed("jump") and host.hasDoubleJump:
		host.velocity.y = -host.jumpForce
		swap.emit(self, "d-air")
		return
	
	#The player has reached the apex of their jump
	if host.velocity.y > 0:
		swap.emit(self, "fall")
		return
	
	#The player can hold the jump button to go higher
	if Input.is_action_pressed("jump"):
		host.velocity.y -= host.flyForce * delta
	
	host.velocity.x = cterp(host.velocity.x, host.input * host.walkSpeed, host.accel * delta)
	host.velocity.y += host.gravity * delta
	
	host.move_and_slide()
