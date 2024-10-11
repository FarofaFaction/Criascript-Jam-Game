extends State

@export var doctor : Doctor
var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter():
	if !doctor:
		return
	randomize_wander()

func Exit():
	pass

func Update():
	if !doctor:
		return
	#if wander_time > 0:
		#wander_time -= 0.016
	#else:
		#randomize_wander()
	if GlobalTimer.is_time(doctor.hour_assingment, doctor.minutes_assingment):
		Transitioned.emit(self, "DoctorWalkin")
	pass

func Physics_Update():
	if !doctor:
		return
	doctor.velocity = Vector2.ZERO
	pass
