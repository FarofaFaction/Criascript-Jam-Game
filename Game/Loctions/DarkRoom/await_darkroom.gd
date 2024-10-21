extends State

@export var key : Node2D
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
	print(Dialogic.VAR.Darkroom.Convencido)
	if Dialogic.VAR.Darkroom.Convencido:
		Transitioned.emit(self, "PacientWalkout")
		if key:
			if is_instance_valid(key):
				key.reveal()
	pass

func Physics_Update():
	if !pacient:
		return
	pacient.velocity = Vector2.ZERO
	pass
	
func Interaction():
	Dialogic.start('timelineDarkroom')
	pass
