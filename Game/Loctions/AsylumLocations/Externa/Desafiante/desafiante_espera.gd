extends State

@export var pacient : Pacient
@export var SpeakingArea : Area2D

func Enter():
	if !pacient || !SpeakingArea:
		return
	SpeakingArea.monitoring = true
	#pacient.visible = false

func Exit():
	if !pacient || !SpeakingArea:
		return
	SpeakingArea.monitoring = false
	pass

func Update():
	if !pacient:
		return
	if GlobalTimer.time_passed(pacient.hour_to_sleep):
		Transitioned.emit(self, "PacientWalkout")
	pass

func Physics_Update():
	if !pacient:
		return
	pacient.velocity = Vector2.ZERO
	pass
	
