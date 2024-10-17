extends CharacterBody2D

@export var Sprite : AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var _is_running := false
var current_animation: AnimationState = AnimationState.IDLE
enum AnimationState {
	IDLE,
	WALK,
	RUN,
	PUSH,
	WAKE_UP,
	DIE
}

func _ready() -> void:
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

func _set_movement_input():
	_is_running = Input.is_action_pressed("Run")

func _physics_process(delta: float) -> void:
	_set_movement_input()
	# Add the gravity.
	if not is_on_floor():
		velocity += Vector2(0, 980.0) * delta

	# Handle jump.
	if Input.is_action_just_pressed("Power") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		_change_animation(AnimationState.RUN)
		if _is_running:
			velocity.x = direction * SPEED * 2
		else:
			velocity.x = direction * SPEED
	else:
		_change_animation(AnimationState.IDLE)
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	Sprite.flip_h = velocity.x < 0
	move_and_slide()
