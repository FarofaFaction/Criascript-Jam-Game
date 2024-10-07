extends Control

@onready var Bar := $Bar
@onready var Player := get_tree().get_first_node_in_group("Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (!Player):
		return
	Bar.size.x = Player.Sanity * 3
	pass
