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

const Loading := "res://Interface/Transition/Loading.tscn"
const MenuMenu := "res://Interface/Menu/menu.tscn"
const Game := "res://Game/Room/room.tscn"
var current_scene: String
#const ss := str(1)

func change_scene(scene: String):
	#var node
	if (scene == "Menu"):
		#node = preload(MenuMenu).instantiate()
		#get_tree().change_scene_to_file(MenuMenu)
		current_scene = MenuMenu
	elif (scene == "Game"):
		current_scene = Game
		#get_tree().change_scene_to_file(Game)
	else:
		return
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
