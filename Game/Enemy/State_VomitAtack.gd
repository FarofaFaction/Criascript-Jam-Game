extends State
class_name EnemyVomitAtack

var _vomited_object
@export var vomit_raycast: RayCast2D
@export var vomit : GPUParticles2D
@export var enemy : Enemy
@export var vomit_duration := 1
@export var vomit_timer : Timer
@export var damage_start_timer : Timer
var _doing_damage := false

func Enter():
	print("StartVomitAtack")
	if (!enemy || !vomit_timer || !vomit || !vomit_raycast):
		print("Eenter EnemyVomitAtack (!enemy || !vomit_timer):")
		return
	vomit_timer.connect("timeout", vomit_timeout)
	vomit_timer.wait_time = vomit_duration
	vomit_timer.start()
	damage_start_timer.connect("timeout", start_do_damage)
	damage_start_timer.start()
	vomit.emitting = true

func Exit():
	_doing_damage = false
	vomit.emitting = false
	damage_start_timer.disconnect("timeout", start_do_damage)
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
	#_direction = (enemy.global_position - enemy.LastTarget.global_position).normalized()
	vomit.look_at(enemy.LastTarget.global_position)
	vomit_raycast.look_at(enemy.LastTarget.global_position)
	if (!_doing_damage):
		return
	_vomited_object = vomit_raycast.get_collider()
	if (_vomited_object && (_vomited_object.get_parent() == enemy.LastTarget)):
		if enemy.LastTarget is PlayerClass:
			enemy.LastTarget.take_damage(0.1)
	pass

func vomit_timeout():
	print("Vomit Timer Timeout")
	if enemy.DetectionArea:
		if enemy.DetectionArea.overlaps_area(enemy.LastTarget.Hitbox):
			enemy.Target = enemy.LastTarget
	Transitioned.emit(self, "EnemyFollow")
	pass
	
func start_do_damage():
	_doing_damage = true
	pass
