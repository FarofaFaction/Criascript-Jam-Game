extends Stage

@onready var KnockingSound = $KnockingSound
var _can_open := false
var _redguysatack := false
var _door_opened := false
@export var dialog : Dialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !init_stage():
		return
	DialogSystem.finish_dialog.connect(_on_dialog_finished)
	GlobalTimer.set_time(18, 0)
	GlobalTimer.set_speed(6)
	var DoorPosition = my_quest.get_tool("door")
	if (!DoorPosition):
		my_quest.remove_stage(self.name)
		return
	self.global_position = DoorPosition.global_position
	pass # Replace with function body.

func _on_dialog_finished():
	if (_redguysatack):
		my_quest.load_stage("RedGuy")
	my_quest.remove_stage(self.name)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !_door_opened:
		if (GlobalTimer.hours >= 18 && GlobalTimer.minutes >= 1):
			_can_open = true
	if (!_can_open):
		return
	if (!KnockingSound.playing):
		KnockingSound.play()
	pass

func Interaction():
	if (!_can_open || _door_opened):
		return
	_door_opened = true
	dialog._start_dialog()
	#var node = preload("res://Dialog/DialogClass/DialogClass.tscn").instantiate()
	#add_child(node)
	#my_quest.load_stage("RedGuy")
	#my_quest.remove_stage(self.name)
	pass
