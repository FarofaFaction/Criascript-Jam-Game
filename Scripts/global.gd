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

const Alone := "res://Game/Loctions/LonelinessRoom/LonelinessRoom.tscn"
const Room := "res://Game/Loctions/CommonRoom/CommomRoom.tscn"
const Loading := "res://Interface/Transition/Loading.tscn"
const MenuMenu := "res://Interface/Menu/menu.tscn"
const Corridor := "res://Game/Loctions/Corridor2D/Corridor2D.tscn"
const Game := "res://Game/Loctions/PlayerRoom/PlayerRoom.tscn"
var current_scene: String
var current_destination : String
#const ss := str(1)

func change_scene(scene: String):
	if Global.first_play:
		Global.first_play = false
		GlobalTimer.set_time(7,0)
		GlobalTimer.set_speed(480)
	if (scene == "Menu"):
		GlobalTimer.stop()
		current_scene = MenuMenu
	elif (scene == "Game"):
		current_scene = Game
	elif (scene == "Room"):
		current_scene = Room
	elif (scene == "Corridor"):
		current_scene = Corridor
	elif (scene == "Alone"):
		current_scene = Alone
	else:
		return
	Transition.transition("fade_to_black")
	if player && player is PlayerClass:
		GameStatus.PlayerSanity = player.Sanity
		player.process_mode = PROCESS_MODE_DISABLED
		player = null
	GlobalTimer.stop()
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
