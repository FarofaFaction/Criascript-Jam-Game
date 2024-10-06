extends Sprite2D

@export
var Layer: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var node: StaticBody2D = get_node("Collision")
	print(Layer)
	node.set_collision_mask_value(1, false)
	node.set_collision_mask_value(Layer + 1, true)
	node.set_collision_layer_value(1, false)
	node.set_collision_layer_value(Layer + 1, true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
