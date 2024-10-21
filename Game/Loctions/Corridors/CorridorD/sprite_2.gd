extends AnimatedSprite2D

var ocupied := false
var ocupied2 := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ocupied2:
		return
	
	if Dialogic.VAR.FinalGame.Fim:
		ocupied2 = true
		if Global.player && Global.player is PlayerClass:
			Global.player.process_mode = PROCESS_MODE_DISABLED
		var simultaneous_scene = preload("res://Credits.tscn").instantiate()
		get_tree().root.add_child(simultaneous_scene)
	pass

func Interaction():
	if ocupied:
		return
	ocupied = true
	Dialogic.start('timelineFinal')
	pass
