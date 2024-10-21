extends State

@export var doctor : Doctor
var move_direction : Vector2
var wander_time : float
var _on_scene := false
var _already_speaked := false
@export var DialogScene : Dialog

func Enter():
	if !doctor:
		return
	_on_scene = true

func Exit():
	_on_scene = false
	pass

func Update():
	if !doctor:
		return
	#await  GlobalTimer.time_changed
	#if _already_speaked:
	if GlobalTimer.hours >= doctor.exit_time[0] && GlobalTimer.minutes >= doctor.exit_time[1]:
		Transitioned.emit(self, "DoctorWalkout")
	pass

func Physics_Update():
	if !doctor:
		return
	doctor.velocity = Vector2.ZERO
	pass

func Interaction():
	if !_on_scene:
		return
	
	Dialogic.start('timelineDoctor')
	#DialogScene._start_dialog()
	pass
