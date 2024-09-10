extends State
@export var host:Node
@export var machine:Node
@export var sprite:Node
@export var cooldown:Node

func enter(): #When this state is entered
	sprite.play("wall_left")
	host.velocity = Vector2(0, 0)

func exit(): #Just before this state is exited
	cooldown.start()

func update(_delta): #Equivalent to func process(delta) in the host. Only use process() to call this
	pass

func physics_update(delta):
	
	if Input.is_action_just_pressed("jump"):
		host.velocity.x = -host.wallJumpForce
		host.velocity.y = -host.jumpForce
		host.position.x -= 1
		swap.emit(self, "air")
		return
	
	if host.input < 0:
		host.position.x -= 1
		swap.emit(self, "fall") #FIXME and see if this actually suffices to detach the player. probably not.
		return
	
	if host.is_on_floor():
		swap.emit(self, "idle")
		return
