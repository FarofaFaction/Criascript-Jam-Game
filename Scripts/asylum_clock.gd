extends Node


func _ready() -> void:
	GlobalTimer.time_changed.connect(make_sound)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#
	#pass

func make_sound():
	$AudioStreamPlayer.play()
