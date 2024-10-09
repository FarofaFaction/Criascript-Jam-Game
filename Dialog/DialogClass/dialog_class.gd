extends Control
class_name Dialog
var _id := 0

var _dialog_data: Dictionary = {
}
#var _dialog_data: Dictionary = {
	#0: {
		#"faceset": "image_path",
		#"dialog": "text",
		#"title": "Name"
	#}
#}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is SpeakClass:
			_dialog_data[_id] = {
				"title": child.speaker,
				"dialog": child.text,
				"faceset": child.image
			}
			_id += 1
	if !_dialog_data.is_empty():
		DialogSystem.data = _dialog_data
		DialogSystem.start_dialog()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Power"):
		DialogSystem.data = _dialog_data
		DialogSystem.start_dialog()
	pass
