extends CharacterBody3D


const SPEED = 5.0


func _ready() -> void:
	$Timer.start(1)
	$Timer.connect("timeout", _end_life_time)
	
	

func _end_life_time() -> void:
	var temp = load("res://bullet_lifetime_end.tscn").instantiate()
	get_tree().current_scene.add_child(temp)
	temp.global_position = global_position
	temp.emitting = true
	queue_free()

func _physics_process(delta: float) -> void:
	
	
	move_and_slide()


func _on_hitbox_body_entered(body: Node3D) -> void:
	body.hp -= 1

