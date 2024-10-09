extends Node2D

@export var room : Node2D
@onready var Enemies := $"../../Enemies"

func _ready() -> void:
	GlobalTimer.set_time(18, 0)
	GlobalTimer.set_speed(6)
	pass # Replace with function body.

var event_1 := false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GlobalTimer.hours < 18:
		return
	if GlobalTimer.minutes < 0:
		return
	if (!$Door/KnockingSound.playing):
		$Door/KnockingSound.play()
		#event_1 = true
	pass
