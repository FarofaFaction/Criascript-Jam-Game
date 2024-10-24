extends Node

@export var item : Item
@export var total_damage := 0.0
@export var damage := 0.2
@export var damage_limit = 40

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
		Global.player.take_damage(damage)
		total_damage += damage
	if (total_damage >= damage_limit):
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
