extends State

@export var doctor : Doctor
@export var navigation_agent : NavigationAgent2D

func Enter():
	if (!doctor):
		#print("Eenter DoctorFollow (!doctor || !doctor.DetectionArea):")
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
	if !doctor.target_area:
		return

	var target_position = doctor.target_area.global_position

	if doctor.global_position.distance_to(target_position) > 15:
		navigation_agent.set_target_position(target_position)
		var next_point = navigation_agent.get_next_path_position()
		if next_point:
			doctor.velocity = (next_point - doctor.global_position).normalized() * doctor.speed
	else:
		doctor.velocity = Vector2.ZERO
		Transitioned.emit(self, "DoctorIdle")
		# Transitioned.emit(self, "DoctorIdle")
