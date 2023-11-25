extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

signal died

var has_died = false

var hp:int = 5:
	set(value):
		hp = value
		
		if hp == 0 and not has_died:
			has_died = true
			die()
			emit_signal("died")
			queue_free()
			


func die() -> void:
	var temp = load("res://death_explosion.tscn").instantiate()
	get_tree().current_scene.add_child(temp)
	temp.global_position = global_position
	temp.emitting = true


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

#	var direction = global_position.direction_to(get_tree().current_scene.get_node("Player").global_position)
#	if direction:
#		velocity.x = direction.x * SPEED
#		velocity.z = direction.z * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	$NavigationAgent3D.target_position = get_tree().current_scene.get_node("Player").global_position
	velocity = global_position.direction_to($NavigationAgent3D.get_next_path_position())
	
	if not is_on_floor():
		velocity.y -= gravity * delta * 20

	move_and_slide()
