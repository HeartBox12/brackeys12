extends State
@export var host:Node
@export var machine:Node
@export var sprite:Node

var playerPos


func enter(): #When this state is entered
	pass
	
func exit(): #Just before this state is exited
	pass

func update(_delta): #Equivalent to func process(delta) in the host. Only use process() to call this
	if Input.is_action_just_pressed("jump"):
		host.velocity.y -= host.jumpForce
		swap.emit(self, "air")
		return
	
	if host.faceRight:
		sprite.play("walk_right")
	else:
		sprite.play("walk_left")
	
	if host.input == 0:
		swap.emit(self, "idle")
		return

func physics_update(delta): #Equivalent to func physics_process() in the host.
	if not host.is_on_floor:
		swap.emit(self, "fall")
		return
	
	host.velocity.x = host.input * host.walkSpeed * delta
	host.velocity.y += host.gravity * delta
	host.move_and_slide()
