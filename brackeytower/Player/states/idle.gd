extends State
@export var host:Node
@export var machine:Node
@export var sprite:Node

func enter(): #When this state is entered
	if host.faceRight:
		sprite.play("idle_right")
	else:
		sprite.play("idle_left")
	
func exit(): #Just before this state is exited
	pass

func update(_delta): #Equivalent to func process(delta) in the host. Only use process() to call this
	pass

func physics_update(delta):
	
	if Input.is_action_just_pressed("jump"):
		host.velocity.y -= host.jumpForce
		swap.emit(self, "air")
		return
	
	if host.input != 0:
		swap.emit(self, "walk")
		return
	
	if not host.is_on_floor():
		swap.emit(self, "fall")
		return
	
	host.velocity.x = 0
	host.velocity.y += host.gravity * delta
	host.move_and_slide()
