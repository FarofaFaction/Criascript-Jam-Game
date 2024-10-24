extends CharacterBody2D
class_name Enemy

const pegadas_model := preload("res://Game/Enemy/Redguy/pegadas_vermelhas.tscn")
var LastTarget: Node
var Target: Node

@export var stepsAudioPlayer: AudioStreamPlayer2D
@export var time_to_die : Vector2 = Vector2(6,0)
@export var time_to_pegadas_die : float = 5
@export var pegadas_distance := 1000
@export var DetectionArea: Area2D
@export var SelfArea: Area2D
@export var speed: int = 50
@export var pegadasSpawnNode: Node2D
@export var pegadasSpawnReff: Marker2D
@export var animationPlayer: AnimatedSprite2D
@export var ParticleWeapon: GPUParticles2D

var distance_traveled: float = 0.0  # Distância total percorrida

func _ready() -> void:
	if ParticleWeapon:
		ParticleWeapon.emitting = false

func _process(_delta: float) -> void:
	if GlobalTimer.is_time(time_to_die[0], time_to_die[1]):
		get_parent().remove_child(self)
		queue_free()
	pass

func _physics_process(_delta: float) -> void:
	# Move o inimigo
	if (!velocity):
		if stepsAudioPlayer:
			stepsAudioPlayer.stop()
		animationPlayer.play("Idle")
	else:
		if stepsAudioPlayer && !stepsAudioPlayer.playing:
			stepsAudioPlayer.play()
		animationPlayer.play("Run")
		distance_traveled += velocity.length() + _delta
		spawn_pegadas()  # Verifica e spawn pegadas
		if (velocity.x < 0):
			animationPlayer.flip_h = true
		else:
			animationPlayer.flip_h = false
	move_and_slide()

func spawn_pegadas() -> void:
	#print(distance_traveled)
	if (!pegadasSpawnNode || !pegadasSpawnReff):
		return
	if distance_traveled >= pegadas_distance:
		# Reseta a distância percorrida
		distance_traveled = 0.0

		# Cria uma nova instância de pegadas_model
		var pegadas_instance = pegadas_model.instantiate()
		pegadas_instance.timetodie = time_to_pegadas_die
		pegadasSpawnNode.add_child(pegadas_instance)

		# Define a posição da pegada
		pegadas_instance.global_position = pegadasSpawnReff.global_position

		# Define a rotação da pegada na direção do movimento
		var direction = velocity.normalized()  # Normaliza a direção
		if direction.length() > 0:
			pegadas_instance.rotation = direction.angle()  # Define a rotação
		# Se precisar, você pode ajustar a posição para se alinhar melhor
		# pegadas_instance.position += direction * ajuste_se necessário
