extends Node

@export var pegadas_spawn_node : Node2D
@export var possible_positions : Array[Marker2D]
@export var spawn_node : Node2D
@export var spawn_times : Array[Vector2] = [Vector2(20, 0), Vector2(20, 30)]
var enemyScene = preload("res://Game/Enemy/red_guy.tscn")
var spawned_times : Array = []

# Called when the enemy enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !spawn_node:
		return
	
	for time in spawn_times:
		if not time in spawned_times:
			if GlobalTimer.hours >= time.x && GlobalTimer.minutes >= time.y:
				var enemy = enemyScene.instantiate()
				if possible_positions.size() > 0:
					var random_index = randi() % possible_positions.size()
					var random_position = possible_positions[random_index].global_position
					enemy.global_position = random_position
				else:
					enemy.global_position = Global.player.global_position
					enemy.global_position.x += 100
				if pegadas_spawn_node:
					if enemy is Enemy:
						enemy.pegadasSpawnNode =pegadas_spawn_node
				spawn_node.add_child(enemy)
				spawned_times.append(time)  # Track that this time has been used
				break  # Exit the loop after spawning to prevent multiple spawns in one frame
