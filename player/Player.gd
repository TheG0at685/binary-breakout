extends KinematicBody2D


export var can_wall_jump = true

const SPEED = 300.0
const JUMP_VELOCITY = -700.0

# Jump vars
var jumping = false
var max_jump_count = 1
var jump_count = max_jump_count
var early_jump = false
var wall_jumping = false

# Movment vars
var gravity = 1200
var facing = "right"

# Give us more control over velocity
var vel = Vector2()

func _physics_process(delta):
	motion()
	apply_gravity(delta)
	jump()

	move_and_slide(vel, Vector2(0, -1))

		
	
		
	



func apply_gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		vel.y += gravity * delta
		if Input.is_action_just_pressed("jump"):
			$"Early jump".start()
	else:
		# Shake the camera if it was a large fall
		if vel.y > 1000:
			$Camera2D.trauma = vel.y/2000
		# Reset some values
		jumping = false
		jump_count = max_jump_count
		$"Cyote jump".start()
		if vel.y > 0:
			vel.y = 0
	
	if is_on_ceiling():
		vel.y = 1



func jump():
	# Handle Jump.
	
	# Sorry that the statment looks confusing. Bassicly if $Cyote jump is currently counting down and jump key is pressed and we aren't currently jumping and we still have jumps left, jump
	if $"Cyote jump".time_left > 0 and $"Cyote jump".time_left < $"Cyote jump".wait_time and Input.is_action_just_pressed("jump") and not jumping and jump_count > 0:
		jumping = true
	
	if $"Early jump".time_left > 0 and $"Early jump".time_left < $"Early jump".wait_time and is_on_floor():
		jumping = true
		jump_count = max_jump_count
		early_jump = true
		$"Early jump".stop()
	
	if Input.is_action_just_pressed("jump") and jump_count > 0:
		if is_on_floor():
			jumping = true
		else:
			$"Early jump".start()
			
	if not Input.is_action_pressed("jump") and vel.y < 0:
		vel.y = 0
		
	# Wall jump logic
	if is_on_wall() and (not is_on_floor()) and Input.is_action_just_pressed("jump"):
		print(83)
		if facing == "left":
			facing = "right"
			vel.x = SPEED
		else:
			facing = "left"
			vel.x = -SPEED
		vel.y = JUMP_VELOCITY
		wall_jumping = true
		
	if vel.y > 300 or (not Input.is_action_pressed("jump") or is_on_floor()):
		wall_jumping = false
		
	if jumping and (Input.is_action_just_pressed("jump") or early_jump) and jump_count > 0:
		early_jump = false
		jump_count -= 1
		vel.y = JUMP_VELOCITY
		
	


func motion():
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if not wall_jumping: # This needs to be here otherwise wall jump momentum will be instantly canceled 
		if direction:
			vel.x = clamp(vel.x + direction * SPEED, -SPEED, SPEED)
		else:
			vel.x = clamp(vel.x + move_toward(vel.x, 0, SPEED), -SPEED, SPEED)
	if Input.is_action_pressed("left"):
		facing = "left"
	elif Input.is_action_pressed("right"):
		facing = "right"
	else:
		if not wall_jumping: # Reduce x momentum if we are not moving
			if vel.x < 0:
				vel.x += SPEED/10
			elif vel.x > 0:
				vel.x -= SPEED/10




