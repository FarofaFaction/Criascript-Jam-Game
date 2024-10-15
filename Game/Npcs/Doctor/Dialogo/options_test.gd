extends Control

#@export var dialog: Dialog
func option1():
	print("Opção 1")
	#DialogSystem._reset_dialog()
	DialogSystem._id = DialogSystem.data.size() - 1
	var dialog = preload("res://Game/Npcs/Doctor/Dialogo/possotedar.tscn").instantiate()
	add_child(dialog)
	#dialog._start_dialog()
	pass
# Called when the node enters the scene tree for the first time.
func option2():
	print("Opção 2")
	pass

func option3():
	print("Opção 3")
	pass

func option4():
	print("Opção 4")
	pass
