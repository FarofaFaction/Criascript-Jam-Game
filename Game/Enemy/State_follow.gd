extends State
class_name EnemyFollow

@export var enemy : Enemy
var _move_direction : Vector2 = Vector2.ZERO

func Enter():
	if (!enemy || !enemy.DetectionArea):
		print("Eenter EnemyFollow (!enemy || !enemy.DetectionArea):")
		return
	enemy.DetectionArea.connect("body_exited", body_shape_exited)

func Exit():
	if (!enemy || !enemy.DetectionArea):
		print("Exit EnemyFollow (!enemy || !enemy.DetectionArea):")
		return
	enemy.Target = null
	enemy.DetectionArea.disconnect("body_exited", body_shape_exited)
	pass

func Update():
	if (!enemy):
		return
	if (!enemy.Target || !enemy.SelfArea):
		Transitioned.emit(self, "EnemyIdle")
		return
	pass

func Physics_Update():
	_move_direction = enemy.Target.global_position - enemy.global_position
	
	if  !(enemy.SelfArea.overlaps_body(enemy.Target)):
		enemy.velocity = _move_direction.normalized() * enemy.speed
	else:
		enemy.velocity = Vector2.ZERO
		enemy.LastTarget = enemy.Target
		Transitioned.emit(self, "EnemyVomitAtack")
	pass

func body_shape_exited(body):
	if (body == enemy.Target):
		print(body.name + " Exited on " + self.name + " Detection Area (Follow)")
		Transitioned.emit(self, "EnemyIdle")
	pass
	
