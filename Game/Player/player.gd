extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var _is_running := false

func _run():
	if Input.is_action_pressed("Run"):
		_is_running = true
	else:
		_is_running = false
	pass

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	_run()
	if (_is_running):
		velocity = input_direction * SPEED * 2
	else:
		velocity = input_direction * SPEED
	move_and_slide()
