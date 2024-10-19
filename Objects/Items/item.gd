extends Panel
class_name Item

@export var button_warning : Label
@export var node_instructions : Node
var button : String
@export var usable := false
@export var item_id : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if usable && _is_on_player():
		
		if button_warning.visible == false:
			button_warning.visible = true
			button_warning.text = "Use [" + button + "]"
			tr(button_warning.text)
		if Input.is_action_just_pressed(button):
			if node_instructions:
				if node_instructions.has_method("UseItem"):
					node_instructions.UseItem()
					return
	pass

func _is_on_player():
	var result = GameStatus.PlayerItems.find(self)
	print(result)
	if result >= 0:
		button = str(result + 1)
		return true
	return false
	pass
