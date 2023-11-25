extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var mouseSensibility = 1200
var mouse_rel_x = 0
var mouse_rel_y = 0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation.y -= event.relative.x / mouseSensibility
		$Head/Camera3D.rotation.x -= event.relative.y / mouseSensibility
		$Head/Camera3D.rotation.x = clamp($Head/Camera3D.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
		mouse_rel_x = clamp(event.relative.x, -50, 50)
		mouse_rel_y = clamp(event.relative.y, -50, 50)
	
	if event is InputEventKey:
		if Input.is_action_just_pressed("toggle_lock_mouse"):
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = 0
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				var temp = load("res://bullet.tscn").instantiate()
				$Pew.play()
				get_tree().current_scene.add_child(temp)
				temp.global_position = $Head.global_position
				temp.rotation.y = rotation.y
				temp.velocity = $Head.global_position.direction_to($Node3D.global_position).normalized()*10
