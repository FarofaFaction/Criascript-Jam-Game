extends State

@export var pacient : Pacient
@export var navigation_agent : NavigationAgent2D

func Enter():
	if (!pacient):
		print("Eenter DoctorFollow (!pacient || !pacient.DetectionArea):")
		return
	if navigation_agent && pacient.exit_area:
		pacient.collision_layer = 0
		pacient.collision_mask = 0
		navigation_agent.set_target_position(pacient.exit_area.global_position)


func Exit():
	#timer.queue_free()
	#timer = null7
	pacient.collision_mask = 2
	pass

func Update():
	pass

func Physics_Update():
	
	if !pacient:
		return
	if !pacient.target_area:
		return
	
	var target_position = pacient.target_area.global_position

	if pacient.global_position.distance_to(target_position) > 30:
		navigation_agent.set_target_position(target_position)
		var next_point = navigation_agent.get_next_path_position()
		if next_point:
			pacient.velocity = (next_point - pacient.global_position).normalized() * pacient.speed
	else:
		pacient.velocity = Vector2.ZERO
		Transitioned.emit(self, "PacientIdle")
		# Transitioned.emit(self, "DoctorIdle")
