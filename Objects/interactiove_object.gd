extends Sprite2D
class_name InteractiveObject

@export var CollisionLayer: int = 0
@export var LightLayer: int = 0

var collisionNode: StaticBody2D

func _set_collision_mask(layer: int):
	if (!collisionNode):
		return
	layer += 1
	if (layer > 32 || layer < 1):
		return
	var i := 1
	while (i <= 32):
		collisionNode.set_collision_mask_value(i, false)
		i += 1
	collisionNode.set_collision_mask_value(layer, true)
	pass

func _set_collision_layer(layer: int):
	if (!collisionNode):
		return
	layer += 1
	if (layer > 32 || layer < 1):
		return
	var i := 1
	while (i <= 32):
		collisionNode.set_collision_layer_value(i, false)
		i += 1
	collisionNode.set_collision_layer_value(layer, true)
	pass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collisionNode = get_node("Collision")
	_set_collision_layer(CollisionLayer)
	_set_collision_mask(CollisionLayer)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
