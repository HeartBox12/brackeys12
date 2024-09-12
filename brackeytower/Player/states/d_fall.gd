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
		sprite.play("fall_right")
	else:
		sprite.play("fall_left")

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
	
	host.velocity.x = cterp(host.velocity.x, host.input * host.walkSpeed, host.accel * delta)
	host.velocity.y = cterp(host.velocity.y, host.fallSpeed, host.gravity * delta)
	
	var temp = host.velocity
	
	host.move_and_slide()
