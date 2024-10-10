extends Control
class_name Menu

var _button_array: Array[Button]

@export var init_button: Button
@export var backup_button: Button
@onready var _on_ready_init_button_grab = _grab_init_button()
@export var searchButtons := false
#@onready var print_Result = _debug()

func _debug():
	print(init_button)
	pass

func _grab_init_button():
	if (init_button):
		init_button.grab_focus()
	if (searchButtons):
		setup_buttons()

func _add_menu(menu_instance: Menu) -> void:
	if (!init_button):
		get_parent().add_child(menu_instance)
		return
	menu_instance.backup_button = init_button
	get_parent().add_child(menu_instance)


func _exit_menu() -> void:
	if (backup_button):
		backup_button.grab_focus()
	get_parent().remove_child(self)
	queue_free();
	pass

func find_buttons(node: Node) -> void:
	for child in node.get_children():
		if child is Button:
			_button_array.append(child)
		# Chama a função recursivamente para filhos dos filhos
		find_buttons(child)

# Método para configurar os botões
func setup_buttons() -> void:
	if (_button_array.is_empty()):
		return
	for i in range(_button_array.size()):
		# Define a navegação para cada botão
		if i == 0:
			_button_array[i].set("focus_neighbor_bottom", _button_array[i + 1])
			_button_array[i].set("focus_next", _button_array[i + 1])
			_button_array[i].set("focus_neighbour_right", _button_array[i + 1])
			_button_array[i].set("focus_neighbour_top", _button_array[_button_array.size() - 1])
			_button_array[i].set("focus_previous", _button_array[_button_array.size() - 1])
			_button_array[i].set("focus_neighbour_left", _button_array[_button_array.size() - 1])
		elif i == _button_array.size() - 1:
			_button_array[i].set("focus_neighbor_bottom", _button_array[0])
			_button_array[i].set("focus_next", _button_array[0])
			_button_array[i].set("focus_neighbour_right", _button_array[0])
			_button_array[i].set("focus_neighbour_top", _button_array[i - 1])
			_button_array[i].set("focus_previous", _button_array[i - 1])
			_button_array[i].set("focus_neighbour_left", _button_array[i - 1])
		else:
			_button_array[i].set("focus_neighbor_bottom", _button_array[i + 1])
			_button_array[i].set("focus_next", _button_array[i + 1])
			_button_array[i].set("focus_neighbour_right", _button_array[i + 1])
			_button_array[i].set("focus_neighbour_top", _button_array[i - 1])
			_button_array[i].set("focus_previous", _button_array[i - 1])
			_button_array[i].set("focus_neighbour_left", _button_array[i - 1])
			pass
	
	# Define o botão inicial para receber o foco
	if !init_button && _button_array.size() > 0:
		_button_array[0].grab_focus()
	else:
		_grab_init_button()

# Método chamado ao pressionar um botão
func _on_button_pressed(index: int) -> void:
	print("Botão " + str(index) + " pressionado")

## Exemplo de uso no método _ready
#func _ready() -> void:
	#var buttons = [
		#$Button1,
		#$Button2,
		#$Button3
	#]
	#setup_buttons(buttons)

	
