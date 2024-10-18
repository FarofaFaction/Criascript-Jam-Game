extends State

@export var doctor : Doctor

func Enter():
	if !doctor:
		return
	await get_tree().create_timer(1).timeout
	if GlobalTimer.time_passed(doctor.exit_time):
		return
	if GlobalTimer.time_passed(Vector2(doctor.hour_assingment, doctor.minutes_assingment)):
		doctor.visible = true
		if doctor.target_area:
			doctor.global_position = doctor.target_area.global_position
		Transitioned.emit(self, "DoctorWalkin")
	#doctor.visible = false

func Exit():
	pass

func Update():
	if !doctor:
		return
	doctor.visible = false
	if GlobalTimer.is_time(doctor.hour_assingment, doctor.minutes_assingment):
		doctor.visible = true
		Transitioned.emit(self, "DoctorWalkin")
		return
	pass

func Physics_Update():
	if !doctor:
		return
	doctor.velocity = Vector2.ZERO
	pass
	
