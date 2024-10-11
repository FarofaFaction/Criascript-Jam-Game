extends Control
class_name Dialog
var _id := 0
var _dialog_data: Dictionary = {
}

@export var auto_start := true
#@export var auto_destroy := false
#var _dialog_data: Dictionary = {
	#0: {
		#"faceset": "image_path",
		#"dialog": "text",
		#"title": "Name"
	#}
#}

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if auto_start:
		_start_dialog()
	#if auto_destroy:
		#await DialogSystem.finish_dialog
		#_destroy_self()
	pass

func _destroy_self():
	print("destroyng dialog instance")
	get_parent().remove_child(self)
	self.queue_free()

func _start_dialog():
	#visible = true
	for child in get_children():
		if child is DialogMenu:
			_add_menu(child)
			_id += 1
		if child is SpeakClass:
			_add_label(child)
			_id += 1
	if !_dialog_data.is_empty():
		DialogSystem.data = _dialog_data
		DialogSystem.start_dialog()
	pass # Replace with function body.

func _add_label(child: SpeakClass):
	_dialog_data[_id] = {
		"title": child.speaker,
		"dialog": child.text,
		"faceset": child.texture
	}

func _add_menu(child: Menu):
	remove_child(child)
	_dialog_data[_id] = child

### Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Power"):
		#DialogSystem.data = _dialog_data
		#DialogSystem.start_dialog()
	#pass
