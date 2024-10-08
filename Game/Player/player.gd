extends CharacterBody2D
class_name PlayerClass

@export var spritePlayer: AnimatedSprite2D
@export var Hitbox :Area2D
@export var StepsAudioPlayer: AudioStreamPlayer2D
@export var DamageAudioPlayer: AudioStreamPlayer2D
var Sanity := 100.0
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var _is_running := false

func _run():
	if Input.is_action_pressed("Run"):
		_is_running = true
	else:
		_is_running = false
	pass

func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	_run()
	if (_is_running):
		velocity = input_direction * SPEED * 2
	else:
		velocity = input_direction * SPEED
	if (!velocity):
		spritePlayer.play("Idle")
	else:
		spritePlayer.play("Run")
		if (velocity.x < 0):
			spritePlayer.flip_h = true
		else:
			spritePlayer.flip_h = false
		#print("Gabriel")
	move_and_slide()

func take_damage(damage: float):
	if (!DamageAudioPlayer.playing):
		DamageAudioPlayer.play()
	Sanity -= damage
