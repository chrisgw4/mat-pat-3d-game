extends StaticBody3D


var spawn_waves:bool = false

static var kills:int = 0
static var num_enemies:int = 15
var counter = 0

@onready var kill_label = get_tree().current_scene.get_node("Label3D")

signal wave_complete

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	kill_label.text = "Kills: 0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn_waves:
		pass


func _spawn_waves() -> void:
	spawn_waves = true
	$Timer.start(1.5)
	$Timer.connect("timeout", _spawn_enemy)

func _spawn_enemy():
	if counter >= num_enemies:
		return
	var i = randi_range(0,3)
	var temp = load("res://enemy.tscn").instantiate()
	get_tree().current_scene.add_child(temp)
	counter += 1
	
	if i == 0:
		temp.global_position = $SpawnPos1.global_position
	elif i == 1:
		temp.global_position = $SpawnPos2.global_position
	elif i == 2:
		temp.global_position = $SpawnPos3.global_position
	elif i == 3:
		temp.global_position = $SpawnPos4.global_position
	
	temp.connect("died", _count_kills)
		

func _count_kills() -> void:
	kills += 1
	kill_label.text = "Kills: " + str(kills)
	
	if kills == num_enemies:
		emit_signal("wave_complete")
		$Timer.stop()
