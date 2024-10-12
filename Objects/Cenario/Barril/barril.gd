extends RigidBody2D

var player_holding: bool = false
var offset: Vector2 = Vector2(0, -50)  # Ajuste o deslocamento conforme necessário
var player := Global.player
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if player_holding:
		keep_holding()

func keep_holding():
	if player:
		# Atualiza a posição do barril para manter o deslocamento relativo ao jogador
		global_position = player.global_position + offset

func Interaction():
	player = Global.player
	if player_holding:
		player_holding = false
		player._can_run = true
		collision_mask = 2
		collision_layer = 2
	else:
		if player:
			# Define o deslocamento inicial quando o barril é pegado
			offset = global_position - player.global_position
			player_holding = true
			player._can_run = false
			collision_mask = 0
			collision_layer = 0
