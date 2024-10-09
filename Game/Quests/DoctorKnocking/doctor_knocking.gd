extends Quest

@export var DoorSoundOrigin: Marker2D
const DoctorKnocking = "res://Game/Quests/DoctorKnocking/stage_1/DoctorKnocking_1.tscn"
const RedGuy = "res://Game/Quests/DoctorKnocking/RedGuyTime/RedGuyTime.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_stage("DoctorKnocking", "res://Game/Quests/DoctorKnocking/stage_1/DoctorKnocking_1.tscn")
	add_tool("door", DoorSoundOrigin)
	add_stage("RedGuy", RedGuy)
	load_stage("DoctorKnocking")
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
