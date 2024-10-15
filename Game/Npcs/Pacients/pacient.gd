extends CharacterBody2D
class_name Pacient

@export var hour_assingment := 7
@export var minutes_assingment := 5
@export var exit_area : Marker2D
@export var target_area : Marker2D
@export var DetectionArea : Area2D
@export var SelfArea : Area2D
@export var speed: int = 50
@export var animationPlayer : AnimatedSprite2D

func _ready() -> void:
	visible = true
	pass
	
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
