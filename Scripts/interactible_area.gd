extends Area2D


@export var moving_parent: Node
var _interactible : Node
var _player : PlayerClass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var node = get_parent()
	if node && node is Node:
		_interactible = node
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_interaction_controler()
	pass

func _physics_process(_delta: float) -> void:
	if moving_parent:
		self.global_position = moving_parent.global_position
	pass

func _interaction_controler():
	if !_player || !_interactible:
		return
	if _player._died:
		return
	if !_interactible.has_method("Interaction"):
		return
	if (Input.is_action_just_pressed("Interact")):
		_interactible.Interaction()
	pass

func _player_entered(area) -> void:
	var node = area.get_parent()
	if !node:
		return
	if node is not PlayerClass:
		return
	print("Player entered on interctible area")
	_player = node
	pass # Replace with function body.

func _player_exited(area) -> void:
	var node = area.get_parent()
	if !node || node != _player:
		return
	print("Player exit out interctible area")
	_player = null
	pass 
