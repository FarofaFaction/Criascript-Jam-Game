extends Node

var first_murmur := true
var murmur_ok := false
@export var hour_to_sleep : Vector2 = Vector2(18,0)
@export var murmurAudioPlayer : AudioStreamPlayer2D
@export var time_to_stop_murmur := Vector2(18, 0)
@export var positions_to_go: Array[Marker2D]
@export var positions_to_sleep: Array[Marker2D]
@export var spawn_node: Node2D
@export var spawn_time := Vector2(7, 0)
@export var number_of_patients: int = 10  # Número de pacientes a serem instanciados
var pacientScene := preload("res://Game/Npcs/Pacients/Pacient.tscn")
var pacientsSpawned := false

# Called when the pacient enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	await get_tree().create_timer(1).timeout
	#print(str(GlobalTimer.hours) + " " + str(GlobalTimer.minutes))
	#print(GlobalTimer.time_passed(spawn_time))
	if GlobalTimer.time_passed(spawn_time):
		_spawn_pacients_on_midle_day()
		pacientsSpawned = true
	if GlobalTimer.time_passed(hour_to_sleep):
		pacientsSpawned = true
	set_process(true)
	pass

func control_murmur():
	#print(murmur_ok)
	if !murmurAudioPlayer:
		return
	if GlobalTimer.hours >= spawn_time.x and GlobalTimer.minutes >= spawn_time.y:
		murmur_ok = true
	if murmur_ok:
		if !murmurAudioPlayer.playing:
			if first_murmur:
				murmurAudioPlayer.volume_db = -40
			murmurAudioPlayer.play()
			if first_murmur:
				var tween = create_tween()
				tween.tween_property(murmurAudioPlayer, "volume_db", 0, 5)
				first_murmur = false
	if GlobalTimer.hours >= time_to_stop_murmur.x and GlobalTimer.minutes >= time_to_stop_murmur.y:
		first_murmur = true
		var tween = create_tween()
		tween.tween_property(murmurAudioPlayer, "volume_db", -40, 5)
		await  tween.finished
		murmurAudioPlayer.stop()
		murmur_ok = false
	pass

func _process(_delta: float) -> void:
	control_pacients_spawning()
	control_murmur()


func control_pacients_spawning():
	if !spawn_node:
		return
	# Reseta o array pacientsSpawned à meia-noite
	if GlobalTimer.hours == 0 and GlobalTimer.minutes >= 0:
		pacientsSpawned = false
	if 	pacientsSpawned:
		return
	if GlobalTimer.hours >= spawn_time.x and GlobalTimer.minutes >= spawn_time.y:
		_spawn_pacients()
		pacientsSpawned = true
	pass


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
		var randT := randf_range(0.0,1.5)
		await get_tree().create_timer(randT).timeout
		spawn_node.add_child(pacient)



func _spawn_pacients_on_midle_day():
	for i in range(number_of_patients):
		var pacient: Pacient = pacientScene.instantiate()
		
		# Escolhe uma posição aleatória para dormir
		if positions_to_sleep.size() > 0 && positions_to_go.size() > 0:
			var random_index = randi() % positions_to_go.size()
			pacient.target_area = positions_to_go[random_index]
			
			pacient.global_position = positions_to_go[random_index].global_position
			pacient.global_position.x += randi() % 31 - 15  # Offset entre -15 e 15
			pacient.global_position.y += randi() % 31 - 15  # Offset entre -15 e 15

			random_index = randi() % positions_to_sleep.size()
			pacient.exit_area = positions_to_sleep[random_index]
		else:
			pacient.global_position = Global.player.global_position
			pacient.global_position.x += 100
		# Adiciona o paciente ao nó de spawn
		var randT := randf_range(0.0,1.5)
		await get_tree().create_timer(randT).timeout
		spawn_node.add_child(pacient)
