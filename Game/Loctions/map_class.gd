extends Node2D
class_name Map

@export var destinations : Array[Marker2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTimer.start()
	InGamePause.monitoring = true
	Transition.transition("fade_out_black")
	if !Global.current_destination:
		return
	
	if destinations.size() > 0:
		for dest in destinations:
			if dest.name == Global.current_destination:
				if Global.player:
					Global.player.global_position = dest.global_position
					Global.current_destination = ""
					return
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
