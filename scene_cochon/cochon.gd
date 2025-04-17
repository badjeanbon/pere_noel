extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var queue = $Trail2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#print("entre ", delta)
	if not is_on_floor():
		velocity += get_gravity() * delta
		#print("vole")
	#Handle jump.
	if Input.is_action_just_pressed("ui_saute") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$son_jump.play()
		
	var fuse = false
	if Input.is_action_pressed("ui_fuse"):
		velocity.y = JUMP_VELOCITY / 4
		fuse = true
		queue.visible = true
		if not $son_fuse.is_playing():
			$son_fuse.play()

	else:
		queue.visible = false
		
	
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			$anim.play("move_right")
		else:
			$anim.play("move_left")
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
