extends Node2D

@export var door_id : String
@export var current_message : Label
@export var lockedMessage : Label
@export var openMessage : Label
@export var locked := false
@export var destination: String = ""
@export var location: String = "Corridor"
@export var interactiveArea: InteractibleArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameStatus.DoorsOppened.size() > 0:
		if GameStatus.DoorsOppened.find(door_id) >= 0:
			locked = false
		pass
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if !interactiveArea:
		#return
	#if interactiveArea._player:
	if locked:
		current_message.text = lockedMessage.text
	else:
		current_message.text = openMessage.text
	pass

func Interaction():
	if locked:
		for it in GameStatus.PlayerItems:
			if it.item_id == door_id:
				locked = false
				GameStatus.DoorsOppened.append(door_id)
				GameStatus.PlayerItems.remove_at(GameStatus.PlayerItems.find(it))
				it.queue_free()
		return
	#GameStatus.pl
	Global.current_destination = destination
	Global.change_scene(location)
	pass
