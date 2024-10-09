extends Stage

func _ready() -> void:
	if !init_stage():
		return
	GlobalTimer.set_speed(60)
	var pos: Node2D = my_quest.get_tool("door")
	if pos:
		for i in 30:
			var node = preload("res://Game/Enemy/red_guy.tscn").instantiate()
			node.global_position = pos.global_position
			$Node2D.add_child(node)
			i += 1
			print(i)
		
	pass
#
#
#func _process(_delta: float) -> void:
	#pass
