extends Node
class_name Quest

var Stages: Dictionary = {}
var Tools: Dictionary = {}

func add_stage(_name: String, path: String):
	Stages[_name] = path
	pass

func add_tool(_name: String, node):
	Tools[_name] = node
	pass

func get_tool(_name: String) -> Node:
	var node = Tools[_name]
	return node

func load_stage(_name: String):
	var node = Stages[_name]
	if (!node):
		print("Stage not found!")
		return
	var instance = load(node).instantiate()
	self.add_child(instance)

func remove_stage(_name: String):
	var node = get_node(_name)
	if (!node):
		print("Stage not found!")
		return
	self.remove_child(node)
	node.queue_free()
	pass
	
#func _process(_delta: float) -> void:
	#pass
