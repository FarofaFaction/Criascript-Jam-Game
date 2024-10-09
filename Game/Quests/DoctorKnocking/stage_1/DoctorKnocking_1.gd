extends Stage

@onready var KnockingSound = $KnockingSound
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !init_stage():
		return
	GlobalTimer.set_time(18, 0)
	GlobalTimer.set_speed(6)
	var DoorPosition = my_quest.get_tool("door")
	if (!DoorPosition):
		my_quest.remove_stage(self.name)
		return
	self.global_position = DoorPosition.global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GlobalTimer.hours < 18:
		return
	if GlobalTimer.minutes < 1:
		return
	if (!KnockingSound.playing):
		KnockingSound.play()
	pass

func Interaction():
	my_quest.load_stage("RedGuy")
	my_quest.remove_stage(self.name)
	pass
