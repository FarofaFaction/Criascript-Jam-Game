extends Node

var first_play := true
var on_menu := false

# AUDIO
var bus_name: String = "Master"
var bus_index: int
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	_init_audio()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _init_audio():
	bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(0.5))
	pass
