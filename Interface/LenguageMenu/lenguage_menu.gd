extends Menu

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func _on_english_pressed() -> void:
	change_language("en")
	pass # Replace with function body.


func _on_portuguese_pressed() -> void:
	change_language("pt_BR")
	pass # Replace with function body.

func change_language(lang: String) -> void:
	TranslationServer.set_locale(lang)
	pass
	


func _on_quit_pressed() -> void:
	_exit_menu()
	pass # Replace with function body.
