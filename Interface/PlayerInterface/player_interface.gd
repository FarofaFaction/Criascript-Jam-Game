extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Dialogic.VAR.FinalGame.Fim:
		visible = false
		return
	if visible == false:
		visible = true
	pass
