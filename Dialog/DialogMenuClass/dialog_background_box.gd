extends ColorRect

@export var reference : Node
@export var border := 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if reference:
		self.size = reference.size
		self.size.y += border
		self.size.x += border
		self.position = reference.position
		self.position.x -= border / 2
		self.position.y -= border / 2
	pass
