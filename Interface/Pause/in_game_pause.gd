extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if (get_tree().paused == true):
			get_tree().paused = false
		else:
			get_tree().paused = true
		pass
	pass
