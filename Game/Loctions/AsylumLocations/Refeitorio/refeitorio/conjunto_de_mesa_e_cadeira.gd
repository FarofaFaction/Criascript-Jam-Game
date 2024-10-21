extends Node2D

@export var PacientBallon := Label
@export var id := "Nada"
var pedindo := false
var completed := false
@export var Central : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Central:
		return
	pass

func get_mesa_id():
	return id

func hide_arguing():
	$Pacient/SacaledTextBallon2/Textpanel/Arguing.visible = false
	pass

func show_arguing():
	$Pacient/SacaledTextBallon2/Textpanel/Arguing.visible = true
	pass

func _on_timer_timeout() -> void:
	if !Central:
		return
	if pedindo:
		return
	var it = randi_range(0, 6)
	PacientBallon.text = Central.get_node("NomesDeComida").get_child(it).text
	var node = Central.list_[it].instantiate()
	id = node.item_id
	node.queue_free()
	#PacientBallon.visible = true
	pedindo = true
	pass # Replace with function body.


func _on_pedido_timeout() -> void:
	PacientBallon.visible = true
	await get_tree().create_timer(2).timeout
	PacientBallon.visible = false
	$Pedido.wait_time = randf_range(1.0,2.5)
	pass # Replace with function body.
