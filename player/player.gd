extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("attack"):
		$Camera3D/Hand.attack()
	if Input.is_action_just_pressed("reload"):
		get_tree().call_group("weapon_display","reload")

func _physics_process(delta):
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/100)
		velocity.z = move_toward(velocity.z, 0, SPEED/100)
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y += JUMP_VELOCITY
	move_and_slide()

func _input(event):
	move_camera(event as InputEventMouseMotion)

func move_camera(motion:InputEventMouseMotion):
	if !motion or Input.mouse_mode != Input.MOUSE_MODE_CAPTURED: return
	var movement = motion.get_relative()*Settings.mouse_sense
	$Camera3D.rotate_x(-deg_to_rad(movement.y))
	rotate_y(-deg_to_rad(movement.x))

func take_damage(val:float):
	print("ow ",val)
