extends Node2D

@export var actual_label : Label
@export var label_list : Node2D

# Chama quando o nó entra na árvore de cena pela primeira vez.
func _ready() -> void:
	if !actual_label or !label_list:
		return

	# Inicia o processo de exibir rótulos aleatórios.
	var wait_time = randf_range(5, 30)
	await get_tree().create_timer(wait_time).timeout
	show_random_label()

# Função para exibir um rótulo aleatório.
func show_random_label() -> void:
	var random_index = randi() % label_list.get_child_count()
	var random_label = label_list.get_child(random_index) as Label

	actual_label.text = random_label.text
	actual_label.visible = true
	
	# Espera 2 segundos antes de esconder o rótulo.
	await get_tree().create_timer(3).timeout
	
	# Esconde o rótulo.
	actual_label.visible = false
	
	# Espera entre 2 e 4 segundos antes de mostrar um novo rótulo.
	var wait_time = randf_range(10, 20)
	await get_tree().create_timer(wait_time).timeout
	
	# Chama novamente a função para mostrar outro rótulo aleatório.
	show_random_label()
