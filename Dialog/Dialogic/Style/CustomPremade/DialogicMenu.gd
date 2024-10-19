extends Menu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InGamePause.hold_pause = true
	get_tree().paused = true
	InGamePause.current_menu = self
	pass # Replace with function body.

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		InGamePause.hold_pause = false
		InGamePause.current_menu = null
		InGamePause.dispause()
		#get_tree().paused = false
		
		pass
