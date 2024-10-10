extends Node

var monitoring := false
var game_paused := false
var hold_pause := false
var current_menu : Menu

const PauseMenu := "res://Interface/Pause/pause_options.tscn"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (!monitoring):
		return
	if Input.is_action_just_pressed("ui_cancel"):
		if (game_paused):
			remove_childs()
			game_paused = false
			if 	current_menu:
				current_menu._grab_init_button()
				return
			if !hold_pause:
				get_tree().paused = false
		else:
			var node = preload(PauseMenu).instantiate()
			$CanvasLayer.add_child(node)
			get_tree().paused = true
			game_paused = true
		pass
	pass

func _pause():
	pass
	
func _dispause():
	pass

func remove_childs():
	var children = $CanvasLayer.get_children()
	for c in children:
		$CanvasLayer.remove_child(c)
		c.queue_free()
	pass
