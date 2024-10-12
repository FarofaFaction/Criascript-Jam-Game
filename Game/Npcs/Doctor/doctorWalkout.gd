extends State

@export var doctor : Doctor
func Enter():
	if (!doctor):
		print("Eenter DoctorFollow (!doctor || !doctor.DetectionArea):")
		return
	#timer = Timer.new()
	#timer.wait_time = 1
	#timer.start()


func Exit():
	#timer.queue_free()
	#timer = null7
	pass

func Update():
	pass

func Physics_Update():
	if !doctor:
		return
	if !doctor.exit_area:
		return

	var target_position = doctor.exit_area.global_position
	var random_offset = Vector2(randf(), randf()) * 10  # Ensure you define 'random_offset'
	var random_target_position = target_position + random_offset
	var _move_direction = random_target_position - doctor.global_position

	if doctor.global_position.distance_to(target_position) > 15:
		doctor.velocity = _move_direction.normalized() * doctor.speed
	else:
		doctor.velocity = Vector2.ZERO
		doctor.get_parent().remove_child(doctor)
		doctor.queue_free()
		#Transitioned.emit(self, "DoctorIdle")
