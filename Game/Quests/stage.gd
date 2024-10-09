extends Node
class_name Stage

@onready var my_quest = get_parent()

func _ready() -> void:
	if !init_stage():
		return
	GlobalTimer.set_time(18, 0)
	GlobalTimer.set_speed(6)
	pass
#
#
#func _process(_delta: float) -> void:
	#pass

func init_stage():
	if my_quest is not Quest:
		print("Stage with not quest parent")
		my_quest.remove_child.call_deferred(self)
		queue_free()
		return false
	return true
