extends CharacterBody2D
class_name PlayerClass

@export var awaking := false
@export var InteractArea: Area2D
@export var dying_sound: AudioStream
@export var walking_sound: AudioStream
@export var running_sound: AudioStream
@export var Sprite: AnimatedSprite2D
@export var Hitbox: Area2D
@export var StepsAudioPlayer: AudioStreamPlayer2D
@export var DamageAudioPlayer: AudioStreamPlayer2D
@export var heartbeat_sound: AudioStream
@export var Sanity := 100.0

signal PlayerDied

# Local Vars
var _input_direction: Vector2
var _steps_current_sound
var _can_run := true
var _died := false
var _is_running := false
@export var SPEED = 50.0

# Heartbeat control
var heartbeat_audio_player: AudioStreamPlayer2D
var is_heartbeat_playing := false
var last_sanity := Sanity

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

func _ready() -> void:
	Global.player = self
	PlayerDied.connect(on_player_died)

	# Initialize heartbeat audio player
	heartbeat_audio_player = AudioStreamPlayer2D.new()
	add_child(heartbeat_audio_player)
	heartbeat_audio_player.stream = heartbeat_sound
	heartbeat_audio_player.volume_db = -80 # Start muted

	if awaking:
		current_state = PlayerState.WAKE_UP

func _physics_process(_delta: float) -> void:
	if current_state == PlayerState.DIE:
		_dyng()
		return
	if current_state == PlayerState.WAKE_UP:
		_awaking()
		return	
	if current_state == PlayerState.PUSH:
		_pushing()
		return
	if current_state == PlayerState.NORMAL:
		_normal()
		return

func _normal():
	_set_movement_input()
	_normal_movement()
	_audio_steps_controller()
	move_and_slide()

func _pushing():
	_set_movement_input()
	_pushing_movement()
	_audio_steps_controller()
	move_and_slide()

func _dyng():
	StepsAudioPlayer.stop()
	_change_animation(AnimationState.DIE)
	Global.change_scene("Game")

func _awaking():
	_change_animation(AnimationState.WAKE_UP)
	if Sprite.frame == 3:
		current_state = PlayerState.NORMAL

func _set_movement_input():
	_input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	_is_running = Input.is_action_pressed("Run")
	Sprite.flip_h = _input_direction.x < 0

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
	else:
		self.velocity = Vector2.ZERO
		_change_animation(AnimationState.IDLE)

func _change_animation(new_state: AnimationState):
	if current_animation != new_state:
		current_animation = new_state
		match current_animation:
			AnimationState.IDLE: Sprite.play("Idle")
			AnimationState.WALK: Sprite.play("Walk")
			AnimationState.RUN: Sprite.play("Run")
			AnimationState.DIE: Sprite.play("Die")
			AnimationState.PUSH: Sprite.play("Push")
			AnimationState.WAKE_UP: Sprite.play("WakeUp")

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

func take_damage(damage: float):
	if _died:
		return
	if Sanity - damage <= 0:
		Sanity = 0
		if DamageAudioPlayer.stream != dying_sound:
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
