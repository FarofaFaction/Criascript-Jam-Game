extends Node
class_name Stage

@onready var my_quest = get_parent()

#func _ready() -> void:
	#pass # Replace with function body.
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
