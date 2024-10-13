extends CharacterBody2D
class_name Enemy

const pegadas_model := preload("res://Game/Enemy/Redguy/pegadas_vermelhas.tscn")
var LastTarget: Node
var Target: Node
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

func _physics_process(_delta: float) -> void:
	# Move o inimigo
	if (!velocity):
		animationPlayer.play("Idle")
	else:
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
	if (!pegadasSpawnNode || pegadasSpawnReff):
		return
	if distance_traveled >= pegadas_distance:
		# Reseta a distância percorrida
		distance_traveled = 0.0
		#print(distance_traveled)
		# Cria uma nova instância de pegadas_model
		var pegadas_instance = pegadas_model.instantiate()
		pegadasSpawnNode.add_child(pegadas_instance)
		pegadas_instance.global_position = pegadasSpawnReff.global_position
		#print(pegadas.get_child_count())
		# Posiciona a pegada na posição atual do inimigo
		pegadas_instance.position = position
