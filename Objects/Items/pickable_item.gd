extends Node2D

@export var just_one_intance := true
@export var item : Item
@export var item_id : String = "GenericKey"
@export var item_type : String = "Key"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if item_id:
		if item:
			item.item_id = item_id
	if item_type:
		if item:
			item.item_type = item_type
	if just_one_intance:
		if GameStatus.ItemsHistory.find(item.item_id) >= 0:
			get_parent().remove_child.call_deferred(self)
			self.queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func Interaction():
	if !item:
		return
	if GameStatus.PlayerItems.size() >= 4:
		return
	if just_one_intance:
		GameStatus.ItemsHistory.append(item.item_id)
	item.get_parent().remove_child(item)
	GameStatus.PlayerItems.append(item)
	get_parent().remove_child(self)
	queue_free()
	pass
