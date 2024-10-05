extends Menu

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_full_screen_pressed() -> void:
	var node: Menu = preload("res://Interface/ResolutionMenu/resoltutionMenu.tscn").instantiate()
	_add_menu(node)
	pass

func _on_language_pressed() -> void:
	var node: Menu = preload("res://Interface/LenguageMenu/lenguage_menu.tscn").instantiate()
	_add_menu(node)
	pass # Replace with function body.

func _on_exit_config_pressed() -> void:
	_exit_menu()
	pass # Replace with function body.
