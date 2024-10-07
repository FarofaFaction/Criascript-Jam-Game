extends CharacterBody2D
class_name Enemy

@export var LastTarget : Node
@export var Target : Node
@export var DetectionArea : Area2D
@export var SelfArea : Area2D
@export var speed: int = 100
@export var animationPlayer : AnimatedSprite2D
@export var player: CharacterBody2D

func _physics_process(_delta: float) -> void:

	if (!velocity):
		animationPlayer.play("Idle")
	else:
		animationPlayer.play("Run")
	if (velocity.x < 0):
		animationPlayer.flip_h = true
	else:
		animationPlayer.flip_h = false
	move_and_slide()
