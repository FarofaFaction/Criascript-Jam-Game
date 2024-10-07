extends State
class_name EnemyIdle

@export var enemy : Enemy
var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func Enter():
	if !enemy:
		return
	enemy.DetectionArea.connect("body_entered", body_shape_entered)
	randomize_wander()

func Exit():
	enemy.DetectionArea.disconnect("body_entered", body_shape_entered)
	pass

func Update():
	if wander_time > 0:
		wander_time -= 0.016
	else:
		randomize_wander()
	pass

func Physics_Update():
	if !enemy:
		Transitioned.emit(self, "EnemyFollow")
	enemy.velocity = move_direction * (enemy.speed / 5)

	if (enemy.Target):
		Transitioned.emit(self, "EnemyFollow")
	pass

func body_shape_entered(body):
	if !body.is_in_group("Player"):
		print(body.name + ",Invalid Entered on " + self.name + " Detection Area (Idle)")
		return
	print(body.name + " Entered on " + self.name + " Detection Area (Idle)")
	enemy.Target = body
	Transitioned.emit(self, "EnemyFollow")
	pass
