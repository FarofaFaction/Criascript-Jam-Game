extends Node2D

@export var list_of_nodes : Array[Node2D] = []
@export var sanity_range : Vector2 = Vector2(30.0, 60.0)
var _list_of_sanity_range : Array[float] = []

# Chamada quando o nó entra na árvore de cena pela primeira vez.
func _ready() -> void:
	# Inicializa _list_of_sanity_range com valores aleatórios dentro de sanity_range
	for node in list_of_nodes:
		var random_sanity = randf_range(sanity_range.x, sanity_range.y)
		_list_of_sanity_range.append(random_sanity)

# Chamada a cada frame. 'delta' é o tempo decorrido desde o frame anterior.
func _process(delta: float) -> void:
	# Verifica se o jogador existe
	if !Global.player:
		return

	# Verifica a sanidade do jogador e ajusta a visibilidade dos nós
	var player_sanity = Global.player.Sanity
	for i in range(list_of_nodes.size()):
		if is_instance_valid(list_of_nodes[i]):
			if player_sanity <= _list_of_sanity_range[i]:
				list_of_nodes[i].visible = true
			else:
				list_of_nodes[i].visible = false
