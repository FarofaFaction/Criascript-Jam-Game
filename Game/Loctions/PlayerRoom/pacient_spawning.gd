extends Node

@export var positions_to_go: Array[Marker2D]
@export var positions_to_sleep: Array[Marker2D]
@export var spawn_node: Node2D
@export var spawn_time := Vector2(7, 0)
@export var number_of_patients: int = 10  # Número de pacientes a serem instanciados
var pacientScene := preload("res://Game/Npcs/Pacients/Pacient.tscn")
var pacientsSpawned := false

# Called when the pacient enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !spawn_node:
		return
	
	# Reseta o array pacientsSpawned à meia-noite
	if GlobalTimer.hours == 0 and GlobalTimer.minutes >= 0:
		pacientsSpawned = false
	# for index in total_pacients:
	if 	pacientsSpawned:
		return

	if GlobalTimer.hours >= spawn_time.x and GlobalTimer.minutes >= spawn_time.y:
		_spawn_pacients()
		pacientsSpawned = true


func _spawn_pacients():
	for i in range(number_of_patients):
		var pacient: Pacient = pacientScene.instantiate()
		
		# Escolhe uma posição aleatória para dormir
		if positions_to_sleep.size() > 0 && positions_to_go.size() > 0:
			var random_index = randi() % positions_to_go.size()
			pacient.target_area = positions_to_go[random_index]
			
			random_index = randi() % positions_to_sleep.size()
			pacient.exit_area = positions_to_sleep[random_index]

			pacient.global_position = positions_to_sleep[random_index].global_position
			pacient.global_position.x += randi() % 31 - 15  # Offset entre -15 e 15
			pacient.global_position.y += randi() % 31 - 15  # Offset entre -15 e 15
		else:
			pacient.global_position = Global.player.global_position
			pacient.global_position.x += 100
		# Adiciona o paciente ao nó de spawn
		spawn_node.add_child(pacient)
