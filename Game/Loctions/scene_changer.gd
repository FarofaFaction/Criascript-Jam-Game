extends Node2D

@export var location: String = "Corridor"
@export var interactiveArea: InteractibleArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if !interactiveArea:
		#return
	#if interactiveArea._player:
		
	pass

func Interaction():
	Global.change_scene(location)
	pass
