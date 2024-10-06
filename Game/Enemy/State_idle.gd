extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 10.0
var player = CharacterBody2D
var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
# Called when the node enters the scene tree for the first time.
func Enter():
	player = get_tree().get_first_node_in_group("Player")
	randomize_wander()

func Update():
	if wander_time > 0:
		wander_time -= 0.016
	else:
		randomize_wander()
	pass

func Physics_Update():
	if !enemy:
		Transitioned.emit(self, "EnemyFollow")
	enemy.velocity = move_direction * move_speed
	var direction = player.global_position - enemy.global_position
	
	if (direction.length() < 300):
		Transitioned.emit(self, "EnemyFollow")
	pass
