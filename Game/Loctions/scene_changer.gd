extends Node2D

@export var enabled := true
var timeBlocked := false
#@export var timelocked := false
@export var LockLimitTimeFinal := 6
@export var LockLimitTimeInit := 20
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
	interactiveArea.enabled = enabled
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
	#if T
	#if timelocked:
		#if GlobalTimer.hours <= LockLimitTimeFinal || GlobalTimer.hours >= LockLimitTimeInit:
			#timeBlocked = true
		#else:
			#timeBlocked = false
	if locked || timeBlocked:
		current_message.text = lockedMessage.text
	else:
		current_message.text = openMessage.text
	pass

func Interaction():
	if timeBlocked:
		return
	if locked:
		#locked = false
		#GameStatus.DoorsOppened.append(door_id)
		for it in GameStatus.PlayerItems:
			if it.item_type == "Key":
				locked = false
				GameStatus.DoorsOppened.append(door_id)
				$AudioStreamPlayer2D.play()
				it.remove_item()
		return
	#GameStatus.pl
	if Global.player:
		if Global.player.Sanity < 50:
			var tw = create_tween()
			tw.tween_property(Global.player, "Sanity", 50, 2)
	Global.current_destination = destination
	Global.change_scene(location)
	pass
