extends CharacterBody2D
class_name Doctor

@export var stepsAudioPlayer: AudioStreamPlayer2D
@export var exit_time : Vector2 = Vector2(18,20)
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
		if stepsAudioPlayer:
			stepsAudioPlayer.stop()
		animationPlayer.play("DoctorIdle")
	else:
		if stepsAudioPlayer && !stepsAudioPlayer.playing:
			stepsAudioPlayer.play()
		animationPlayer.play("DoctorRun")
	if (velocity.x < 0):
		animationPlayer.flip_h = true
	else:
		animationPlayer.flip_h = false
	move_and_slide()
