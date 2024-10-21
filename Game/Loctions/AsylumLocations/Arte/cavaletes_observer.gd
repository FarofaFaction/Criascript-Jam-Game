extends Node2D

@export var key := Node2D
@onready var list1 := $"../Coluna1"
@onready var list2 := $"../Coluna2"
var total := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	total = 0
	for i in list1.get_children():
		if i._completed:
			total += 1
	for i in list2.get_children():
		if i._completed:
			total += 1
	if total == 8:
		print(total)
		if key:
			if is_instance_valid(key):
				key.visible = true
		pass
	pass
