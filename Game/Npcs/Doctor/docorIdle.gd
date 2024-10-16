extends State

@export var exit_time : Vector2 = Vector2(18,20)
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
	if GlobalTimer.hours >= exit_time[0] && GlobalTimer.minutes >= exit_time[1]:
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
	if _already_speaked:
		return
	_already_speaked = true
	
	Dialogic.start('timeline_test')
	#DialogScene._start_dialog()
	pass
