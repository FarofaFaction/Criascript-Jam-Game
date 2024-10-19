extends Node2D

@export var item : Item

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func Interaction():
	if !item:
		return
	item.get_parent().remove_child(item)
	GameStatus.PlayerItems.append(item)
	get_parent().remove_child(self)
	queue_free()
	pass
