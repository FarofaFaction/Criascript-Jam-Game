extends State

@export var pacient : Pacient
@export var navigation_agent : NavigationAgent2D

func Enter():
	if (!pacient):
		print("Eenter DoctorFollow (!pacient || !pacient.DetectionArea):")
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
	if !pacient:
		return
	if !pacient.target_area:
		return

	var target_position = pacient.target_area.global_position

	if pacient.global_position.distance_to(target_position) > 15:
		navigation_agent.set_target_position(target_position)
		var next_point = navigation_agent.get_next_path_position()
		if next_point:
			pacient.velocity = (next_point - pacient.global_position).normalized() * pacient.speed
	else:
		pacient.velocity = Vector2.ZERO
		Transitioned.emit(self, "PacientIdle")
		# Transitioned.emit(self, "DoctorIdle")
