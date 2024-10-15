extends State

@export var pacient : Pacient
var move_direction : Vector2
var wander_time : float

func randomize_wander():
	var run := randi_range(0,2)
	if !run:
		move_direction = Vector2.ZERO
		wander_time = randf_range(1, 3)
		return
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter():
	if !pacient:
		return

func Exit():
	pass

func Update():
	if wander_time > 0:
		wander_time -= 0.016
	else:
		randomize_wander()
	pass

func Physics_Update():
	if !pacient:
		return
	pacient.velocity = move_direction * (pacient.speed)
