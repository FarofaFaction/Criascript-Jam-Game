extends RigidBody2D

@export var smallLight: PointLight2D
@export var bigLight: PointLight2D
var player_holding: bool = false
var offset: Vector2 = Vector2(0, -50)  # Ajuste o deslocamento conforme necessário
var player := Global.player

var color_change_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_change_timer = Timer.new()
	color_change_timer.wait_time = randf_range(1, 3)
	color_change_timer.connect("timeout", _on_color_change_timeout)
	add_child(color_change_timer)
	color_change_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if player_holding:
		keep_holding()

func _process(_delta: float) -> void:
	pass
	
func keep_holding():
	if player:
		# Atualiza a posição do barril para manter o deslocamento relativo ao jogador
		global_position = player.global_position + offset

func Interaction():
	player = Global.player
	if player_holding:
		player_holding = false
		player._can_run = true
		player.current_state = player.PlayerState.NORMAL
		collision_mask = 2
		collision_layer = 2
	else:
		if player:
			# Define o deslocamento inicial quando o barril é pegado
			offset = global_position - player.global_position
			player_holding = true
			player._can_run = false
			player.current_state = player.PlayerState.PUSH
			collision_mask = 0
			collision_layer = 0

func _on_color_change_timeout() -> void:
	# Escolhe uma cor aleatória
	if (!smallLight || !bigLight):
		return
	var random_color = Color(randf(), randf(), randf())
	smallLight.color = random_color
	bigLight.color = random_color

	# Reinicia o timer com um novo intervalo aleatório
	color_change_timer.wait_time = randf_range(1, 3)
	color_change_timer.start()
