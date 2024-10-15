extends State

@export var pacient : Pacient
var move_direction : Vector2
var wander_time : float
var _on_scene := false
var _already_speaked := false
@export var DialogScene : Dialog

func Enter():
	if !pacient:
		return
	_on_scene = true

func Exit():
	_on_scene = false
	pass

func Update():
	if !pacient:
		return
	#await  GlobalTimer.time_changed
	if _already_speaked:
		Transitioned.emit(self, "PacientWalkout")
	pass

func Physics_Update():
	if !pacient:
		return
	pacient.velocity = Vector2.ZERO
	pass

func Interaction():
	if !_on_scene:
		return
	if _already_speaked:
		return
	_already_speaked = true
	DialogScene._start_dialog()
	pass
