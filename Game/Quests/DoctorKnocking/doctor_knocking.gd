extends Quest

@export var DoorSoundOrigin: Marker2D
const DoctorKnocking = "res://Game/Quests/DoctorKnocking/stage_1/DoctorKnocking_1.tscn"
const RedGuy = "res://Game/Quests/DoctorKnocking/RedGuyTime/RedGuyTime.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_stage("DoctorKnocking", DoctorKnocking)
	add_tool("door", DoorSoundOrigin)
	add_stage("RedGuy", RedGuy)
	load_stage("DoctorKnocking")
	pass # Replace with function body.


#@onready var shader_material = $"../../CanvasLayer/ColorRect".material

#func _process(_delta):
	# Obtenha a posição global do node
	#var global_pos = $tools/DoorSoundOrigin.global_position

	# Converta a posição para coordenadas de tela (normalizadas)
	# Converta o tamanho da tela para Vector2
	#var screen_size = Vector2(get_viewport().get_size())
#
	## Converta a posição global para coordenadas de tela (normalizadas)
	#var real_center = global_pos / screen_size

	# Atualize o uniform do shader material.set_shader_parameter("TextureMask", textureImage)
	#shader_material.set_shader_parameter("real_center", real_center)
