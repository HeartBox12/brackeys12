extends State
@export var host:Node
@export var machine:Node
@export var sprite:Node

@export var jumpSound:Node
@export var stepSounds:Array #FIXME: Not working right. Cannot get the right values in.
@export var stepSound:Node

var playerPos
var lastFace:bool

func enter(): #When this state is entered
	lastFace = host.faceRight
	
	if sprite.animation.begins_with("turn"):
		pass
	else:
		if host.faceRight:
			sprite.play("walk_right")
		else:
			sprite.play("walk_left")
		
	sprite.animation_finished.connect(_on_sprite_animation_finished)
	sprite.animation_looped.connect(_on_sprite_animation_looped)
	host.turnaround.connect(_on_turnaround)
	
func exit(): #Just before this state is exited
	sprite.animation_finished.disconnect(_on_sprite_animation_finished)
	sprite.animation_looped.disconnect(_on_sprite_animation_looped)
	host.turnaround.disconnect(_on_turnaround)

func update(_delta): #Equivalent to func process(delta) in the host. Only use process() to call this
	
	if host.input == 0:
		swap.emit(self, "idle")
		return
	
	
	lastFace = host.faceRight

func physics_update(delta): #Equivalent to func physics_process() in the host.
	if Input.is_action_just_pressed("jump"):
		host.velocity.y = -host.jumpForce
		jumpSound.play()
		swap.emit(self, "air")
		host.move_and_slide()
		return
	
	if not host.is_on_floor:
		swap.emit(self, "fall")
		return
	
	host.velocity.x = cterp(host.velocity.x, host.input * host.walkSpeed, host.accel * delta)
	host.velocity.y += host.gravity * delta
	host.move_and_slide()

func _on_sprite_animation_finished():
	if host.faceRight:
		sprite.play("walk_right")
	else:
		sprite.play("walk_left")

func _on_turnaround(faceRight:bool):
	if faceRight:
		sprite.play("turn_right")
	else:
		sprite.play("turn_left")

func _on_sprite_animation_looped():
	stepSound.play()
