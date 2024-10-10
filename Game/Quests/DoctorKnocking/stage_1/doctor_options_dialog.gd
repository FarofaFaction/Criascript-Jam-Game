extends Control

@export var my_stage: Stage

func option1():
	if !my_stage:
		print("not found stage")
		return
	DialogSystem._finish_dialog()
	var node = preload("res://Dialog/DialogClass/DialogClass.tscn").instantiate()
	add_child(node)
	pass

func option2():
	if !my_stage:
		print("not found stage")
		return
	my_stage._redguysatack = true
	pass
