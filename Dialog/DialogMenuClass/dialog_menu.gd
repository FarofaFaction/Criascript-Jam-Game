extends Menu
class_name DialogMenu

@export var options_conection: Node
@export var start_visible := false
@export var option_1_visible := true
@export var option_2_visible := true
@export var option_3_visible := true
@export var option_4_visible := true
@onready var Option1 = $Panel/OptionsContainer/Option1
@onready var Option2 = $Panel/OptionsContainer/Option2
@onready var Option3 = $Panel/OptionsContainer/Option3
@onready var Option4 = $Panel/OptionsContainer/Option4
@onready var _first_visibility_value = _init_visibility()

func _init_visibility():
	InGamePause.monitoring = true
	visible = start_visible
	Option1.visible = option_1_visible
	Option2.visible = option_2_visible
	Option3.visible = option_3_visible
	Option4.visible = option_4_visible
	if (options_conection):
		if  options_conection.get_node("option1"):
			Option1.text = options_conection.get_node("option1").text
		if  options_conection.get_node("option2"):
			Option2.text = options_conection.get_node("option2").text
		if  options_conection.get_node("option3"):
			Option3.text = options_conection.get_node("option3").text
		if  options_conection.get_node("option4"):
			Option4.text = options_conection.get_node("option4").text
	return visible

func show_menu():
	if (!options_conection):
		hide_menu()
		return false
	init_button.grab_focus()
	InGamePause.current_menu = self
	visible = true
	return true

func hide_menu():
	get_parent().remove_child(self)
	DialogSystem.on_options = false
	visible = false
	Input.action_press("Interact")
	InGamePause.current_menu = null
	queue_free()

func _on_option_1_pressed() -> void:
	if (!options_conection):
		hide_menu()
		return
	if options_conection.has_method("option1"):
		options_conection.option1()
	hide_menu()
	pass # Replace with function body.


func _on_option_2_pressed() -> void:
	if (!options_conection):
		hide_menu()
		return
	if options_conection.has_method("option1"):
		options_conection.option1()
	hide_menu()
	pass # Replace with function body.


func _on_option_3_pressed() -> void:
	if (!options_conection):
		hide_menu()
		return
	if options_conection.has_method("option1"):
		options_conection.option1()
	hide_menu()
	pass # Replace with function body.


func _on_option_4_pressed() -> void:
	if (!options_conection):
		hide_menu()
		return
	if options_conection.has_method("option1"):
		options_conection.option1()
	hide_menu()
	pass # Replace with function body.
