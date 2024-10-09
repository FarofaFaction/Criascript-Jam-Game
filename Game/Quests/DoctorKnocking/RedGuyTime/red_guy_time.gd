extends Stage

func _ready() -> void:
	if !init_stage():
		return
	GlobalTimer.set_speed(60)
	var pos: Node2D = my_quest.get_tool("door")
	if pos:
		var node = preload("res://Game/Enemy/red_guy.tscn").instantiate()
		node.global_position = pos.global_position
		add_child(node)
		
	pass
#
#
#func _process(_delta: float) -> void:
	#pass
