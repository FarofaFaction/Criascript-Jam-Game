extends Node2D

@export var init_hour := 7
@export var speed := 60
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTimer.set_time(init_hour,0)
	GlobalTimer.set_speed(speed)
	InGamePause.monitoring = true
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
