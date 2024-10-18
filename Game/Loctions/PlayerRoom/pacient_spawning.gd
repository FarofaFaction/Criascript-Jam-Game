extends Node

@export var positions_to_go: Array[Marker2D]
@export var positions_to_sleep: Array[Marker2D]
@export var spawn_node: Node2D
@export var spawn_times: Array[Vector2] = [Vector2(20, 0), Vector2(20, 30)]
@export var number_of_patients: int = 10  # Número de pacientes a serem instanciados
var pacientScene := preload("res://Game/Npcs/Pacients/Pacient.tscn")
var spawned_times: Array = []

# Called when the pacient enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !spawn_node:
		return
	
	# Reseta o array spawned_times à meia-noite
	if GlobalTimer.hours == 0 and GlobalTimer.minutes >= 0:
		spawned_times.clear()
	
	for time in spawn_times:
		if not time in spawned_times:
			if GlobalTimer.hours >= time.x and GlobalTimer.minutes >= time.y:
				for i in range(number_of_patients):  # Loop para criar múltiplos pacientes
					var pacient: Pacient = pacientScene.instantiate()
					if positions_to_go.size() > 0:
						var random_index = randi() % positions_to_go.size()
						
						pacient.target_area = positions_to_go[random_index]
						
						
						random_index = randi() % positions_to_sleep.size()
						pacient.global_position = positions_to_sleep[random_index].global_position
						pacient.global_position.x += randi() % 31 - 15  # Offset entre -15 e 15
						pacient.global_position.y += randi() % 31 - 15  # Offset entre -15 e 15
						pacient.exit_area = positions_to_sleep[random_index]
					else:
						pacient.global_position = Global.player.global_position
						pacient.global_position.x += 100
					
					spawn_node.add_child(pacient)
				spawned_times.append(time)  # Marca que esse tempo foi usado
				break  # Sair do loop após gerar os pacientes para evitar múltiplos spawns na mesma atualização
