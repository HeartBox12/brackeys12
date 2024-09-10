extends State
@export var host:Node
@export var machine:Node
@export var sprite:Node

func enter(): #When this state is entered
	if sprite.animation.begins_with("turn"):
		pass
	else:
		if host.faceRight:
			sprite.play("idle_right")
		else:
			sprite.play("idle_left")
	
	sprite.animation_finished.connect(_on_sprite_animation_finished)
	host.turnaround.connect(_on_turnaround)
	
func exit(): #Just before this state is exited
	sprite.animation_finished.disconnect(_on_sprite_animation_finished)
	host.turnaround.disconnect(_on_turnaround)


func update(_delta): #Equivalent to func process(delta) in the host. Only use process() to call this
	pass

func physics_update(delta):
	
	#Jumped
	if Input.is_action_just_pressed("jump"):
		host.velocity.y = -host.jumpForce
		swap.emit(self, "air")
		host.move_and_slide()
		return
	
	#Started walking
	if host.input != 0:
		swap.emit(self, "walk")
		return
	
	#walked off an edge
	if not host.is_on_floor():
		swap.emit(self, "fall")
		return
	
	host.velocity.x = cterp(host.velocity.x, 0, host.accel * delta)
	host.velocity.y += host.gravity * delta
	host.move_and_slide()


func _on_sprite_animation_finished():
	if host.faceRight:
		sprite.play("idle_right")
	else:
		sprite.play("idle_left")

func _on_turnaround(faceRight:bool):
	if faceRight:
		sprite.play("turn_right")
	else:
		sprite.play("turn_left")
	
