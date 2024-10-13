extends Control

# Variáveis de controle
signal finish_dialog

var _step: float = 0.02
var _id: int = 0
var data: Dictionary = {}
var _on_dialog := false

@export_category("Objects")
@export var _name: Label
@export var _dialog: RichTextLabel
@export var _faceset: TextureRect
var on_options := false
@onready var on_options_observer := on_options

# Chamado quando o nó entra na árvore
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$CanvasLayer.visible = false

# Métodos de Inicialização
func start_dialog() -> void:
	_on_dialog = true
	InGamePause.hold_pause = true
	$CanvasLayer.visible = true
	_initialize_dialog()
	get_tree().paused = true

func _initialize_dialog() -> void:
	if data.is_empty():
		return
	if data[_id] is DialogMenu:
		var node = data[_id]
		$CanvasLayer.add_child(node)
		if node.show_menu():
			on_options = true
		return
	_update_dialog_elements()
	_show_dialog_gradually()

# Atualiza os elementos do diálogo
func _update_dialog_elements() -> void:
	_name.text = data[_id]["title"]
	_dialog.text = data[_id]["dialog"]
	_faceset.texture = data[_id]["faceset"]
	_dialog.visible_characters = 0 

# Mostra o diálogo gradualmente
func _show_dialog_gradually() -> void:
	while _dialog.visible_ratio < 1:
		if _step > 0:
			await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1

# Chamado a cada frame
func _process(delta: float) -> void:
	if !_on_dialog:
		return
	if (on_options_observer != on_options):
		if (on_options_observer == true):
			_id += 1
			if _id >= data.size():
				_finish_dialog()
				return
			_initialize_dialog()
			on_options_observer = on_options
			return
		on_options_observer = on_options
	if (on_options):
		return
	if InGamePause.game_paused:
		return
	if (!data.is_empty() && _id == data.size()):
		_finish_dialog()
		return
	if $CanvasLayer.visible:
		_run_dialog(delta)

# Métodos de Controle de Diálogo
func _run_dialog(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		if _dialog.visible_ratio < 1:
			_step = 0  # Interrompe a exibição gradual do texto
		else:
			_id += 1
			if _id >= data.size():
				_finish_dialog()
				return
			_step = 0.2 * delta
			_initialize_dialog()

func _finish_dialog() -> void:
	data = {}
	finish_dialog.emit()
	$CanvasLayer.visible = false
	_id = 0
	_on_dialog = false
	InGamePause.hold_pause = false
	get_tree().paused = false
