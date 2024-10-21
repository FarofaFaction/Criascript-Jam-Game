extends Node

var first_play := true

var player : PlayerClass
# AUDIO
var bus_name: String = "Master"
var bus_index: int
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	_init_audio()
	pass # Replace with function body.

const DarkRoom := "res://Game/Loctions/DarkRoom/DarkRoom.tscn"
const Art := "res://Game/Loctions/AsylumLocations/Arte/ArtRoom.tscn"
const Extern := "res://Game/Loctions/AsylumLocations/Externa/ExternRoom.tscn"
const Refeitorio := "res://Game/Loctions/AsylumLocations/Refeitorio/RefeitorioRoom.tscn"
const Safe := "res://Game/Loctions/SafeRoom/SafeRoom.tscn"
const Alone := "res://Game/Loctions/LonelinessRoom/LonelinessRoom.tscn"
const Loading := "res://Interface/Transition/Loading.tscn"
const MenuMenu := "res://Interface/Menu/menu.tscn"
const CorridorA := "res://Game/Loctions/Corridors/CorridorA/CorridorA.tscn"
const CorridorB := "res://Game/Loctions/Corridors/CorridorB/CorridorB.tscn"
const CorridorC := "res://Game/Loctions/Corridors/CorridorC/CorridorC.tscn"
const CorridorD := "res://Game/Loctions/Corridors/CorridorD/CorridorD.tscn"
const Room := "res://Game/Loctions/Room/Room.tscn"
var current_scene: String
var current_destination : String
#const ss := str(1)

func change_scene(scene: String, cutscene : bool = false):
	if Global.first_play:
		Global.first_play = false
		GlobalTimer.set_time(7,0)
		GlobalTimer.set_speed(60)
	if (scene == "Menu"):
		GlobalTimer.stop()
		current_scene = MenuMenu
	elif (scene == "Room"):
		current_scene = Room
	elif (scene == "DarkRoom"):
		current_scene = DarkRoom
	elif (scene == "CorridorA"):
		current_scene = CorridorA
	elif (scene == "CorridorB"):
		current_scene = CorridorB
	elif (scene == "CorridorC"):
		current_scene = CorridorC
	elif (scene == "CorridorD"):
		current_scene = CorridorD
	elif (scene == "Alone"):
		current_scene = Alone
	elif (scene == "Safe"):
		current_scene = Safe
	elif (scene == "Art"):
		current_scene = Art
	elif (scene == "Extern"):
		current_scene = Extern
	elif (scene == "Refeitorio"):
		current_scene = Refeitorio
	else:
		return
	if player && player is PlayerClass:
		player.process_mode = PROCESS_MODE_DISABLED
		player = null
	GlobalTimer.stop()
	if cutscene:
		Transition.transition("fade_to_black")
		await Transition.on_transition_finished
	get_tree().change_scene_to_file(Loading)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _init_audio():
	bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(0.5))
	pass
