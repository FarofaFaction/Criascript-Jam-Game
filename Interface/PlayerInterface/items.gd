extends Control

@export var list : VBoxContainer

var last_size := 0
var items_size := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !list:
		return
	last_size = GameStatus.PlayerItems.size()
	items_size = last_size
	add_items()
	pass # Replace with function body.


func add_items():
	for i in list.get_children():
		remove_child(i)
		i.queue_free()
	for i in GameStatus.PlayerItems:
		var it = i.duplicate()
		list.add_child(it)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	items_size = GameStatus.PlayerItems.size()
	if items_size != last_size:
		add_items()
	last_size = items_size
	pass
