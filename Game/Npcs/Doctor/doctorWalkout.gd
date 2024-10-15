extends State

@export var doctor : Doctor
@export var navigation_agent : NavigationAgent2D  # Referência ao Navigation2D

func Enter():
	if !doctor or !doctor.DetectionArea:
		print("Enter DoctorFollow: No doctor or detection area.")
		return

	# Iniciar o movimento do doutor
	navigation_agent.set_target_position(doctor.exit_area.global_position)

func Exit():
	# Limpar estado ao sair
	pass

func Update():
	pass

func Physics_Update():
	if !doctor:
		return
	# Verifique se o doutor está na área de saída
	if !doctor.exit_area:
		return
	# Obter a posição alvo e calcular um deslocamento aleatório
	var target_position = doctor.exit_area.global_position
	# Verifique a distância até a posição alvo
	if doctor.global_position.distance_to(target_position) > 15:
		navigation_agent.set_target_position(target_position)
		var next_point = navigation_agent.get_next_path_position()
		if next_point:
			doctor.velocity = (next_point - doctor.global_position).normalized() * doctor.speed
	else:
		doctor.velocity = Vector2.ZERO
		doctor.get_parent().remove_child(doctor)
		doctor.queue_free()
		# Transitioned.emit(self, "DoctorIdle")
