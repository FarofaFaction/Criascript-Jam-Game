extends Node2D

@export var working := false
@export var NomesDeComida : Node2D
@export var distributionLine : Node2D
@export var mesas : Array[Node2D] = []

var list_ := [
	preload("res://Objects/Items/Cozinha/Hotdog.tscn"),
	preload("res://Objects/Items/Cozinha/Hamburguer.tscn"),
	preload("res://Objects/Items/Cozinha/Pizza.tscn"),
	preload("res://Objects/Items/Cozinha/Melancia.tscn"),
	preload("res://Objects/Items/Cozinha/Refri.tscn"),
	preload("res://Objects/Items/Cozinha/Suco.tscn"),
	preload("res://Objects/Items/Cozinha/Pernil.tscn")
]

var _actual_index := 0

# Tempo de espera para instanciar uma nova bandeja (em segundos)
var instantiation_timer := 3.0

func _ready() -> void:
	# Iniciar o timer que cria novas bandejas de comida a cada 3 segundos
	_start_instantiation_process()

func _start_instantiation_process() -> void:
	# Configura um timer para instanciar bandejas periodicamente
	var timer = Timer.new()
	timer.wait_time = instantiation_timer
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()

# Função chamada quando o timer expira
func _on_timer_timeout() -> void:
	if working and distributionLine.get_child_count() <= 4:
		select_new_index()

func select_new_index() -> void:
	# Seleciona um novo índice aleatório para a comida
	_actual_index = randi_range(0, list_.size() - 1)
	_instantiate_bandeija()

func _instantiate_bandeija() -> void:
	# Instancia a comida e adiciona à bandeja
	var node = list_[_actual_index].instantiate()
	var bandeja = preload("res://Game/Loctions/AsylumLocations/Refeitorio/bandeija.tscn").instantiate()
	
	# Adiciona a comida à bandeja
	bandeja.get_node("Comida").add_child(node)
	bandeja.comida = node
	
	# Adiciona a bandeja à linha de distribuição
	distributionLine.add_child(bandeja)
	bandeja.position.x = 25 * distributionLine.get_child_count()

func _process(delta: float) -> void:
	# Se o turno da noite começar, para de trabalhar
	if $"../../../Illumination".on_night:
		working = false
