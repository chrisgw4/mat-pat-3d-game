extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$MatNode.connect("start_waves", $NavigationRegion3D/Block._spawn_waves)
	$NavigationRegion3D/Block.connect("wave_complete", $MatNode._found_lore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
