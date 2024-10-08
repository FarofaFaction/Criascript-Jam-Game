extends Node2D

@export var room : Node2D
@onready var Enemies := $"../../Enemies"

func _ready() -> void:
	GlobalTimer.set_time(18, 0)
	GlobalTimer.set_speed(6)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
