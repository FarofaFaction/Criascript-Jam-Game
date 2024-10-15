extends State

@export var pacient : Pacient

func Enter():
	if !pacient:
		return
	#pacient.visible = false

func Exit():
	pass

func Update():
	if !pacient:
		return
	pacient.visible = false
	if GlobalTimer.is_time(pacient.hour_assingment, pacient.minutes_assingment):
		pacient.visible = true
		Transitioned.emit(self, "PacientWalkin")
	pass

func Physics_Update():
	if !pacient:
		return
	pacient.velocity = Vector2.ZERO
	pass
	
