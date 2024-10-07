extends CharacterBody2D

const SPEED = 300.0

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
