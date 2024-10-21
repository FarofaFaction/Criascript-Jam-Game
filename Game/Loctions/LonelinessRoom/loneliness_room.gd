extends Map

var _lonelinesRoomDelay := true

func delay_sanity_damage():
	await get_tree().create_timer(3).timeout
	_lonelinesRoomDelay = false
	return true

func _process(_delta: float) -> void:
	if _lonelinesRoomDelay:
		delay_sanity_damage()
		return
	if Global.player:
		if Global.player.Sanity > 20:
			Global.player.take_damage(0.1)
