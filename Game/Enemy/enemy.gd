extends CharacterBody2D

const SPEED = 300.0

@export var player: CharacterBody2D

func _physics_process(delta: float) -> void:

	move_and_slide()
