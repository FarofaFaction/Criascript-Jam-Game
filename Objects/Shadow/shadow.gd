extends Sprite2D

var parent : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	if !parent:
		queue_free()
		return
	if parent is Sprite2D:
		self.texture = parent.texture
	pass # Replace with function body.
