extends Node2D

@export var init_hour := 7
@export var speed := 60
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTimer.start()
	GlobalTimer.set_time(init_hour,0)
	GlobalTimer.set_speed(speed)
	InGamePause.monitoring = true
	Transition.transition("fade_out_black")
	pass # Replace with function body.


#var _spawned := false
### Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#if _spawned:
		#return
		#
	#if GlobalTimer.hours >= 6:
		#var node = preload("res://Game/Enemy/red_guy.tscn").instantiate()
		#node.global_position = Global.player.global_position
		#node.global_position.x += 100
		#$OrganizadosPorY/Personagens.add_child(node)
		#_spawned = true
	#pass
