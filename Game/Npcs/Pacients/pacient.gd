extends CharacterBody2D
class_name Pacient

@export var stepsAudioPlayer: AudioStreamPlayer2D
@export var hour_to_sleep : Vector2 = Vector2(18,0)
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
		animationPlayer.play("Idle")
	else:
		if stepsAudioPlayer && !stepsAudioPlayer.playing:
			stepsAudioPlayer.play()
		animationPlayer.play("Run")
	if (velocity.x < 0):
		animationPlayer.flip_h = true
	else:
		animationPlayer.flip_h = false
	move_and_slide()
	
func change_state(sss: State):
	$"State Machine".current_state.Transitioned.emit(self, sss)
	pass
