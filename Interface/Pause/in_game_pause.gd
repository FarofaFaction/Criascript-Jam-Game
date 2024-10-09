extends Node

const PauseMenu := "res://Interface/Pause/pause_options.tscn"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if DialogSystem.visible:
		return
	if Input.is_action_just_pressed("ui_cancel"):
		if (get_tree().paused == true):
			remove_childs()
			get_tree().paused = false
		else:
			var node = preload(PauseMenu).instantiate()
			add_child(node)
			get_tree().paused = true
		pass
	pass

func remove_childs():
	var children = self.get_children()
	for c in children:
		self.remove_child(c)
		c.queue_free()
	pass
