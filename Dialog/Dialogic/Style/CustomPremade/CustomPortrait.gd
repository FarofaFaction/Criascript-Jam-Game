extends DialogicBackground


#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("dialogic_default_action"):
		#get_parent().remove_child(self)
		#queue_free()
	#pass
