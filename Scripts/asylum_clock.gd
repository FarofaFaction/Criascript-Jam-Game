extends Node


func _ready() -> void:
	GlobalTimer.time_changed.connect(make_sound)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#
	#pass

func make_sound():
	if GlobalTimer.hours == 6 || GlobalTimer.hours == 12 || GlobalTimer.hours == 20:
		#$AudioStreamPlayer.play()]
		print("sino tocando, devo manter ?")
		pass
