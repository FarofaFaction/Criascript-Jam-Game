extends Area2D
class_name InteractibleArea

@export var enabled := true
@export var messagePanel : Panel
@export var message: Label
@export var moving_parent: Node
var _interactible : Node
var _player : PlayerClass
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if message:
		message.visible = false
	if messagePanel:
		messagePanel.visible = false
	var node = get_parent()
	if node && node is Node:
		_interactible = node
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !enabled:
		return
	_interaction_controler()
	pass

func _physics_process(_delta: float) -> void:
	if !enabled:
		return
	if moving_parent:
		self.global_position = moving_parent.global_position
	pass

func _interaction_controler():
	if !enabled:
		return
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
	if !enabled:
		return
	var node = area.get_parent()
	if !node:
		return
	if node is not PlayerClass:
		return
	if message:
		print(enabled)
		message.visible = true
	if messagePanel:
		messagePanel.visible = true
	_player = node
	pass # Replace with function body.

func _player_exited(area) -> void:
	if !enabled:
		return
	var node = area.get_parent()
	if !node || node != _player:
		return
	if message:
		message.visible = false
	if messagePanel:
		messagePanel.visible = false
	#print("Player exit out interctible area")
	_player = null
	pass 
	
func show_message():
	message.visible = true
	pass

func hide_message():
	message.visible = false
	pass

func enable():
	enabled = true
	pass
func disable():
	enabled = false
	pass
