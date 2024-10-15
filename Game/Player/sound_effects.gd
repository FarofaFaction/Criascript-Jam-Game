extends Node

@export  var heart_beats_player: AudioStreamPlayer
@export var player: PlayerClass
@export var _heart_beats_increasing := false

var _last_sanity : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !heart_beats_player || !player:
		get_parent().remove_child.call_deferred(self)
		queue_free()
		return
	_last_sanity = player.Sanity
	heart_beats_player.volume_db = -80
	pass # Replace with function body.


#
func monitor_heart_beats(_delta: float):
	if player.Sanity < 30:
		heart_beats_player.volume_db += 400.0 * _delta
		if heart_beats_player.volume_db >= 1.5:
			heart_beats_player.volume_db = 1.5
		return
	if (player.Sanity != _last_sanity):
		_heart_beats_increasing = true
	else:
		_heart_beats_increasing = false
	_last_sanity = player.Sanity
	if !heart_beats_player.playing:
		heart_beats_player.play()
	if _heart_beats_increasing:
		heart_beats_player.volume_db += 100.0 * _delta
		if heart_beats_player.volume_db >= 1:
			heart_beats_player.volume_db = 1
		#print("Increasing")
	else:
		heart_beats_player.volume_db -= 3.0 * _delta
		#print("Decreasing")
		if heart_beats_player.volume_db < -40:
			heart_beats_player.volume_db = -80
	#print(heart_beats_player.volume_db)
	pass

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	monitor_heart_beats(_delta)
	pass
