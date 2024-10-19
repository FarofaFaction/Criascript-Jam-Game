extends Map

var _SafeRoomDelay := true

func delay_sanity_cure():
	await get_tree().create_timer(3).timeout
	_SafeRoomDelay = false
	return true

func _process(_delta: float) -> void:
	if _SafeRoomDelay:
		delay_sanity_cure()
		
		return
	if Global.player:
		Global.player.cure_damage(0.1)
