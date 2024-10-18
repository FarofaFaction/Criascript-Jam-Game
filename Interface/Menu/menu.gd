extends Control

@export var Color1 : Color
@export var Color2 : Color
const LenguageMenu := "res://Interface/LenguageMenu/lenguage_menu.tscn"
const ConfigMenu := "res://Interface/ConfigMenu/config_menu.tscn"
const MenuMenu := "res://Interface/Menu/menu_options.tscn"

var current_index: int = 0
var current_node: Node = null

func _load_intro():
	var MenuNode: Menu
	MenuNode = preload(MenuMenu).instantiate()
	add_child(MenuNode)
	var ConfigNode: Menu
	ConfigNode = preload(ConfigMenu).instantiate()
	ConfigNode.init_button.get_parent().get_node("ExitConfig").text = $LocalizationTools/StartGameText.text
	ConfigNode.backup_button = MenuNode.init_button
	add_child(ConfigNode)
	var LenguageNode: Menu
	LenguageNode = preload(LenguageMenu).instantiate()
	LenguageNode.backup_button = ConfigNode.init_button
	add_child(LenguageNode)
	pass

func _ready():
	$AudioStreamPlayer.pitch_scale = 0.25
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("new_animation")
	InGamePause.monitoring = false
	if Global.first_play:
		_load_intro()
	else:
		var node = preload("res://Interface/Menu/menu_options.tscn").instantiate()
		add_child(node)
	pass

@export var shader : TextureRect

func _process(_delta):
	#shader
	
	# Verifica se o node atual foi concluído
	return

func _set_color():
	#await get_tree().create_timer(2).timeout
	shader.material.set_shader_parameter("level1", Color1)
	shader.material.set_shader_parameter("level2", Color2)
	#shader.material.set_shader_parameter("level3", Color2)
	pass


func _on_timer_timeout() -> void:
	_set_color()
	pass # Replace with function body.
