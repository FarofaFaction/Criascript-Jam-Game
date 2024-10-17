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

const Loading := "res://Interface/Transition/Loading.tscn"
const MenuMenu := "res://Interface/Menu/menu.tscn"
const Corridor := "res://Game/Loctions/Corridor2D/Corridor2D.tscn"
const Game := "res://Game/Loctions/PlayerRoom/PlayerRoom.tscn"
var current_scene: String
#const ss := str(1)

func change_scene(scene: String):
	#var node
	if (scene == "Menu"):
		#node = preload(MenuMenu).instantiate()
		#get_tree().change_scene_to_file(MenuMenu)
		GlobalTimer.stop()
		current_scene = MenuMenu
	elif (scene == "Game"):
		current_scene = Game
		#get_tree().change_scene_to_file(Game)
	elif (scene == "Corridor"):
		current_scene = Corridor
	else:
		return
	Transition.transition("fade_to_black")
	if player:
		player.process_mode = Node.PROCESS_MODE_DISABLED
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
