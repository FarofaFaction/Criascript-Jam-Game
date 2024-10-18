extends State

@export var pacient : Pacient
var move_direction : Vector2
var wander_time : float

func randomize_wander():
	var stay_parado := randi_range(0,4)
	if stay_parado:
		move_direction = Vector2.ZERO
		wander_time = randf_range(1, 3)
		return
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 2)

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
	if pacient.hour_to_sleep:
		if GlobalTimer.hours >= pacient.hour_to_sleep[0] && GlobalTimer.minutes >= pacient.hour_to_sleep[1]:
			Transitioned.emit(self, "PacientWalkout")
			pass
