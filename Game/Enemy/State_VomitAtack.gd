extends State
class_name EnemyVomitAtack

@export var enemy : Enemy
@export var vomit_duration := 1
@export var vomit_timer : Timer
var _direction := Vector2.ZERO

func Enter():
	print("StartVomitAtack")
	if (!enemy || !vomit_timer):
		print("Eenter EnemyVomitAtack (!enemy || !vomit_timer):")
		return
	vomit_timer.connect("timeout", vomit_timeout)
	vomit_timer.start()

func Exit():
	vomit_timer.disconnect("timeout", vomit_timeout)
	pass

func Update():
	if (!enemy):
		return
	if (!enemy.LastTarget):
		print("No last Target")
		Transitioned.emit(self, "EnemyIdle")
		return
	pass

func Physics_Update():
	if (!enemy.LastTarget):
		Transitioned.emit(self, "EnemyIdle")
		return

	_direction = (enemy.global_position - enemy.LastTarget.global_position).normalized()
	pass

func vomit_timeout():
	print("Vomit Timer Timeout")
	if enemy.DetectionArea:
		if enemy.DetectionArea.overlaps_body(enemy.LastTarget):
			enemy.Target = enemy.LastTarget
	Transitioned.emit(self, "EnemyFollow")
	pass
	
