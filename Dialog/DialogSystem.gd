extends Control

var _step: float = 0.02
var _id: int = 0
var data: Dictionary = {}

@export_category("Objects")
@export var _name: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceset: TextureRect = null

func _ready() -> void:
	print("maicou")
	pass
	
func _initialize_dialog():
	if data.is_empty():
		return
	_name.text = data[_id]["title"]
	_dialog.text = data[_id]["dialog"]
	_faceset.texture = load(data[_id]["faceset"])
	_dialog.visible_characters = 0 
	while _dialog.visible_ratio < 1:
		if (_step != 0):
			await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1
		pass

func _process(delta: float) -> void:
	if (visible):
		_run_dialog(delta)
	pass

func start_dialog():
	visible = true
	get_tree().paused = true
	pass

func _run_dialog(delta: float) -> void:
	if (Input.is_action_just_pressed("Interact") && _dialog.visible_ratio < 1):
		_step = 0
		return
	if (Input.is_action_just_pressed("Interact")):
		_id += 1
		_step = 0.2 * delta
		if (_id == data.size()):
			_finish_dialog()
			return
		_initialize_dialog()
	pass

func _finish_dialog():
	queue_free()
	get_tree().paused = false
	pass
