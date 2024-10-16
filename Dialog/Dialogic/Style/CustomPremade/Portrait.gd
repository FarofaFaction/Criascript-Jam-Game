extends Panel

@export var texture : TextureRect
@export var filter : TextureRect
@export var SearchNode : Node
var save := preload("res://blacksquare.png")
# Called when the node enters the scene tree for the first time.

func find_sprite2d(node: Node) -> Sprite2D:
	# Verifica se o nó atual é um Sprite2D
	if node is Sprite2D:
		return node

	# Itera pelos filhos do nó
	for child in node.get_children():
		var result = find_sprite2d(child)
		if result:
			return result
	# Se não encontrar nenhum Sprite2D, retorna null
	return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var  n = find_sprite2d(SearchNode)
	if !n:
		visible = false
		#texture.texture = save
		#filter.texture = save
		return
	visible = true
	texture.texture = n.texture
	filter.texture = n.texture
	pass
