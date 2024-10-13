extends RichTextLabel
class_name SpeakClass

@export var texture : Texture2D
var image: String
@export var speaker : String
## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tr(speaker)
	#if texture:
		#image = texture.resource_path
	pass # Replace with function body.

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
