extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InGamePause.monitoring = false
	var twe := create_tween()
	var np = $CanvasLayer/Panel/BoxContainer.position
	np.y = -2400
	#twe.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	twe.tween_property($CanvasLayer/Panel/BoxContainer, "position", np, 30 )
	#$AnimationPlayer.play("Creditos")
	#$AnimationPlayer.animation_finished.connect(on_animation_stopped)
	pass # Replace with function body.

func on_animation_stopped():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		GameStatus.reset_game()
		Global.change_scene("Menu")
		get_parent().remove_child(self)
		queue_free()
		pass
	pass
