extends State
class_name EnemyFollow

@export var enemy : Enemy
var _move_direction : Vector2 = Vector2.ZERO
var timer: Timer

var random_radius = 15.0
var random_offset = Vector2(
	randf_range(-random_radius, random_radius),
	randf_range(-random_radius, random_radius)
)

func Enter():
	if (!enemy || !enemy.DetectionArea):
		print("Eenter EnemyFollow (!enemy || !enemy.DetectionArea):")
		return
	#timer = Timer.new()
	#timer.wait_time = 1
	#timer.start()
	
	enemy.DetectionArea.connect("area_exited", body_area_exited)

func Exit():
	#timer.queue_free()
	#timer = null7
	if (enemy):
		enemy.Target = null
	print("Exit Follow State")
	if (enemy.DetectionArea.is_connected("area_exited", body_area_exited)):
		enemy.DetectionArea.disconnect("area_exited", body_area_exited)
	pass

func Update():

	pass

func Physics_Update():
	if (!enemy):
		return
	if (!enemy.Target || !enemy.SelfArea):
		Transitioned.emit(self, "EnemyIdle")
		return

	var target_position = enemy.Target.global_position
	var random_target_position = target_position + random_offset
	_move_direction = random_target_position - enemy.global_position

	if  !(enemy.SelfArea.overlaps_area(enemy.Target.Hitbox)):
		enemy.velocity = _move_direction.normalized() * enemy.speed
	else:
		enemy.velocity = Vector2.ZERO
		enemy.LastTarget = enemy.Target
		Transitioned.emit(self, "EnemyVomitAtack")
	pass

func body_area_exited(area):
	var body = area.get_parent()
	if (body && body == enemy.Target):
		print(body.name + " Exited on " + self.name + " Detection Area (Follow)")
		Transitioned.emit(self, "EnemyIdle")
		if (enemy.DetectionArea.is_connected("area_exited", body_area_exited)):
			enemy.DetectionArea.disconnect("area_exited", body_area_exited)
	pass
	
