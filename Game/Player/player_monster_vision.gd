extends Node2D

@export var player_mid_crazy := 15
@export var player : PlayerClass
@export var light : PointLight2D
var value_init := 0.5
var value_final := 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !player || !light:
		return
	#Debug
	#if Input.is_action_just_pressed("Power"):
		#player.take_damage(5)
	#if Input.is_action_just_pressed("Run"):
		#player.take_damage(-10)
	if player.Sanity > 30:
		light.texture_scale = 0.0
		return
	# Calcular a escala da luz com base na sanidade
	var sanity_percentage = player.Sanity / player_mid_crazy

	if sanity_percentage >= 1.0:
		light.texture_scale = value_init
	elif sanity_percentage >= 0.5:
		light.texture_scale = lerp(value_final, value_init, sanity_percentage)
	else:
		light.texture_scale = value_final * 2
	pass
