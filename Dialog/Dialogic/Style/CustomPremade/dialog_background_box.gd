@tool
extends ColorRect

@export var reference : Node
@export var border := 20
var _on_menu := false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if reference:
		if reference is Label:
			if reference.text.is_empty():
				visible = false
			else:
				visible = true
		elif reference is BoxContainer:
			var node = reference.get_child(0)
			if node:
				visible = node.visible
				pass
		else:
			visible = reference.visible
			pass
		self.size = reference.size
		self.size.y += border
		self.size.x += border
		self.position = reference.position
		self.position.x -= border / 2
		self.position.y -= border / 2
	pass
