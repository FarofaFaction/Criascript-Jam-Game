extends Node2D

@export var timetodie : float = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(timetodie).timeout
	get_parent().remove_child(self)
	queue_free()
	pass # Replace with function body.
