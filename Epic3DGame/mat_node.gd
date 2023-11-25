extends Node3D


var index = 0
var arr = ["Hey Guys welcome to Game Theory.\n\nClick anywhere to continue.", "I need you to help me save the world.\n\nClick anywhere to continue.", "The world is getting overrun by these cylinders and I need you to protect me while I discover the lore.\n\nClick anywhere to continue.", "Use your weapon to destroy them.\n\nClick anywhere to start wave."]

signal start_waves

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label3D.text = arr[index]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed():
				
				index += 1
				if index<len(arr):
					$Label3D.text = arr[index]
					
					if index == 1:
						$MatPat/Help.play()
					elif index == 2:
						$MatPat/Protect.play()
						
					if index == 3:
						$MatPat/Destroy.play()
						print("Starting")
						emit_signal("start_waves")
						await get_tree().create_timer(randi_range(2,15)).timeout
						$MatPat/Calories.play()

func _found_lore() -> void:
	$Label3D.text = "The lore is so clear now."
	$MatPat/Clear.play()
	await $MatPat/Clear.finished
	await get_tree().create_timer(0.5).timeout
	$Label3D.text = "Oh my, I finally found the lore. It all connects back to the Five Nights at Freddys movie. THEY'RE ALL AI."
	$MatPat/Lore.play()
	await $MatPat/Lore.finished
	await get_tree().create_timer(0.5).timeout
	$Label3D.text = "But thats just a theory. A game theory. Thanks for watching."
	$MatPat/Theory.play()
	
