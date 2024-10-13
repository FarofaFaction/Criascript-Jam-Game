extends State

@export var doctor : Doctor

func Enter():
	if !doctor:
		return
	doctor.visible = false

func Exit():
	pass

func Update():
	if !doctor:
		return
	doctor.visible = false
	if GlobalTimer.is_time(doctor.hour_assingment, doctor.minutes_assingment):
		doctor.visible = true
		Transitioned.emit(self, "DoctorWalkin")
	pass

func Physics_Update():
	if !doctor:
		return
	doctor.velocity = Vector2.ZERO
	pass
	
