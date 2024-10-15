extends State

@export var pacient : Pacient
@export var navigation_agent : NavigationAgent2D  # Referência ao Navigation2D

func Enter():
	if !pacient or !pacient.DetectionArea:
		print("Enter DoctorFollow: No pacient or detection area.")
		return

	# Iniciar o movimento do doutor
	navigation_agent.set_target_position(pacient.exit_area.global_position)

func Exit():
	# Limpar estado ao sair
	pass

func Update():
	pass

func Physics_Update():
	if !pacient:
		return
	# Verifique se o doutor está na área de saída
	if !pacient.exit_area:
		return
	# Obter a posição alvo e calcular um deslocamento aleatório
	var target_position = pacient.exit_area.global_position
	# Verifique a distância até a posição alvo
	if pacient.global_position.distance_to(target_position) > 15:
		navigation_agent.set_target_position(target_position)
		var next_point = navigation_agent.get_next_path_position()
		if next_point:
			pacient.velocity = (next_point - pacient.global_position).normalized() * pacient.speed
	else:
		pacient.velocity = Vector2.ZERO
		pacient.get_parent().remove_child(pacient)
		pacient.queue_free()
		# Transitioned.emit(self, "DoctorIdle")
