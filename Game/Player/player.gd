extends CharacterBody2D
class_name PlayerClass

@export var walking_sound : AudioStream
@export var running_sound : AudioStream
@export var spritePlayer: AnimatedSprite2D
@export var Hitbox :Area2D
@export var StepsAudioPlayer: AudioStreamPlayer2D
@export var DamageAudioPlayer: AudioStreamPlayer2D
var Sanity := 100.0

#Local Vars
var _is_running := false
const SPEED = 100.0

func _ready() -> void:
	Transition.transition("fade_out_black")

func _move_speed_controler():
	if Input.is_action_pressed("Run"):
		_is_running = true
	else:
		_is_running = false
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if (_is_running):
		self.velocity = input_direction * SPEED * 2
	else:
		self.velocity = input_direction * SPEED
	pass

func _walk_animation_sprite_controler() -> void:
	if (!velocity):
		spritePlayer.play("Idle")
	else:
		spritePlayer.play("Run")
		if (velocity.x < 0):
			spritePlayer.flip_h = true
		else:
			spritePlayer.flip_h = false
	pass

func _audio_steps_controler() -> void:
	if self.velocity == Vector2.ZERO:
		StepsAudioPlayer.stop()
		return
	
	var current_sound

	if (_is_running):
		current_sound = running_sound;
	else:
		current_sound = walking_sound;

	if (StepsAudioPlayer.stream != current_sound):
		StepsAudioPlayer.stream = current_sound
		
	if !(StepsAudioPlayer.playing):
		StepsAudioPlayer.play()
	pass

func _physics_process(_delta: float) -> void:
	_move_speed_controler()
	_walk_animation_sprite_controler()
	_audio_steps_controler()
	move_and_slide()

func take_damage(damage: float):
	if (!DamageAudioPlayer.playing):
		DamageAudioPlayer.play()
	Sanity -= damage
