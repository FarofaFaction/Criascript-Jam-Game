extends CharacterBody2D
class_name PlayerClass

@export var awaking := false
@export var InteractArea: Area2D
@export var dying_sound: AudioStream
@export var walking_sound: AudioStream
@export var running_sound: AudioStream
@export var ShadowPlayer: AnimatedSprite2D
@export var Sprite: AnimatedSprite2D
@export var Hitbox: Area2D
@export var StepsAudioPlayer: AudioStreamPlayer2D
@export var DamageAudioPlayer: AudioStreamPlayer2D
@export var Sanity := 100.0

signal PlayerDied

# Local Vars
var _input_direction: Vector2
var _steps_current_sound
var _can_run := true
var _died := false
var _is_running := false
@export var SPEED = 50.0

enum AnimationState {
	IDLE,
	WALK,
	RUN,
	PUSH,
	WAKE_UP,
	DIE
}

var current_animation: AnimationState = AnimationState.IDLE

enum PlayerState {
	NORMAL,
	PUSH,
	WAKE_UP,
	DIE
}
var current_state: PlayerState = PlayerState.NORMAL

func _normal():
	_set_movement_input()
	_normal_movement()
	_audio_steps_controller()
	move_and_slide()
	pass

func _pushing():
	_set_movement_input()
	_pushing_movement()
	_audio_steps_controller()
	move_and_slide()
	pass

func _dyng():
	StepsAudioPlayer.stop()
	_change_animation(AnimationState.DIE)
	Global.change_scene("Game")
	pass

func _awaking():
	_change_animation(AnimationState.WAKE_UP)
	if Sprite.frame == 3:
		current_state = PlayerState.NORMAL
	pass

func _ready() -> void:
	Global.player = self
	PlayerDied.connect(on_player_died)
	if awaking:
		current_state = PlayerState.WAKE_UP

func _set_movement_input():
	_input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_pressed("Run"):
		_is_running = true
	else:
		_is_running = false
	if _input_direction.x < 0:
		ShadowPlayer.flip_h = true
		Sprite.scale.x = -1
	else:
		ShadowPlayer.flip_h = false
		Sprite.scale.x = 1
	pass

func _normal_movement():
	if _is_running and _can_run:
		self.velocity = _input_direction * SPEED * 2
		_change_animation(AnimationState.RUN)
	elif _input_direction.length() > 0:
		self.velocity = _input_direction * SPEED
		_change_animation(AnimationState.WALK)
	else:
		self.velocity = Vector2.ZERO
		_change_animation(AnimationState.IDLE)

func _pushing_movement():
	if _input_direction.length() > 0:
		self.velocity = _input_direction * SPEED
		_change_animation(AnimationState.PUSH)
		print(current_animation)
	else:
		self.velocity = Vector2.ZERO
		_change_animation(AnimationState.IDLE)

func _change_animation(new_state: AnimationState):
	if current_animation != new_state:
		current_animation = new_state
		
		match current_animation:
			AnimationState.IDLE:
				Sprite.play("Idle")
				ShadowPlayer.play("Idle")
			AnimationState.WALK:
				Sprite.play("Walk")
				ShadowPlayer.play("Walk")
			AnimationState.RUN:
				Sprite.play("Run")
				ShadowPlayer.play("Run")
			AnimationState.DIE:
				Sprite.play("Die")
				ShadowPlayer.play("Die")
			AnimationState.PUSH:
				Sprite.play("Push")
				ShadowPlayer.play("Push")
			AnimationState.WAKE_UP:
				Sprite.play("WakeUp")  # Certifique-se de que a animação "WakeUp" exista
				ShadowPlayer.play("WakeUp")

func _audio_steps_controller() -> void:
	if self.velocity == Vector2.ZERO:
		StepsAudioPlayer.stop()
		return
	
	if _is_running:
		_steps_current_sound = running_sound
	else:
		_steps_current_sound = walking_sound

	if StepsAudioPlayer.stream != _steps_current_sound:
		StepsAudioPlayer.stream = _steps_current_sound

	if not StepsAudioPlayer.playing:
		StepsAudioPlayer.play()

func _physics_process(_delta: float) -> void:
	if	current_state == PlayerState.DIE:
		_dyng()
		return
	if	current_state == PlayerState.WAKE_UP:
		_awaking()
		return	
	if	current_state == PlayerState.PUSH:
		_pushing()
		return
	if	current_state == PlayerState.NORMAL:
		_normal()
		return

func take_damage(damage: float):
	if _died:
		return
	if Sanity - damage <= 0:
		Sanity = 0
		DamageAudioPlayer.stop()
		DamageAudioPlayer.stream = dying_sound
		DamageAudioPlayer.play()
		_change_animation(AnimationState.DIE)
		PlayerDied.emit()
		return
	if not DamageAudioPlayer.playing:
		DamageAudioPlayer.play()
	Sanity -= damage

func on_player_died():
	current_state = PlayerState.DIE
