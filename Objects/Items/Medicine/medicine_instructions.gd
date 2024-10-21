extends Node

@export var item : Item
@export var total_cure := 0.0
@export var cure := 0.1
@export var cure_limit = 50

func UseItem():
	item.remove_item()
	get_parent().remove_child(self)
	GameStatus.add_child(self)
	set_process(true)
	pass

func _ready() -> void:
	if Global.player:
		Global.player.PlayerDied.connect(on_player_died)
	set_process(false)
	pass
	
func _process(_delta: float) -> void:
	if Global.player:
		Global.player.cure_damage(cure)
		total_cure += cure
	if (total_cure >= cure_limit):
		remove_effect()
	pass

func on_player_died():
	remove_effect()
	pass

func remove_effect():
	var parent = get_parent()
	if parent:
		parent.remove_child(self)
	queue_free()
	pass
