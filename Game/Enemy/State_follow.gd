extends State
class_name EnemyFollow

@export var enemy : CharacterBody2D
@export var move_speed := 290.0
@export var distance := 250
var player = CharacterBody2D
var move_direction : Vector2
#var wander_time : float

#func randomize_wander():
	#move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	#wander_time = randf_range(1, 3)
# Called when the node enters the scene tree for the first time.
func Enter():
	player = get_tree().get_first_node_in_group("Player")

func Update():
	#if wander_time > 0:
		#wander_time -= 0.016
	#else:
		#randomize_wander()
	pass

func Physics_Update():
	if (!enemy || !player):
		return
	var direction = player.global_position - enemy.global_position
	
	if direction.length() > distance:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
	if direction.length() > (distance * 2):
		Transitioned.emit(self, "EnemyIdle")
	pass
