extends State

@export var pacient : Pacient
@export var SpeakingArea : Area2D

func Enter():
	if !pacient || !SpeakingArea:
		return
	SpeakingArea.enable()
	#pacient.visible = false

func Exit():
	if !pacient || !SpeakingArea:
		return
	SpeakingArea.message.visible = false
	SpeakingArea.disable()
	pass

func Update():
	if !pacient:
		return
	if Dialogic.VAR.DesafianteExterna.PartidaComeçou:
		Transitioned.emit(self, "ModoFutebol")
	if GlobalTimer.time_passed(pacient.hour_to_sleep):
		Transitioned.emit(self, "PacientWalkout")
	pass

func Physics_Update():
	if !pacient:
		return
	pacient.velocity = Vector2.ZERO
	pass
	
func Interaction():
	Dialogic.start('timelineDesafio')
	pass
