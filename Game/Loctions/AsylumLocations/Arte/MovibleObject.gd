extends RigidBody2D

@export var _sobrou := false
var _completed := false
@export var lado := false
@export var id := 0
@export var need_id := 0
@export var rayLado : RayCast2D
@export var rayBaixo : RayCast2D
@export var rayOficial : RayCast2D

var player_holding: bool = false
var offset: Vector2 = Vector2(0, -50)  # Ajuste o deslocamento conforme necessário
var player := Global.player
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if player_holding:
		keep_holding()

func get_cavalete_id():
	return id

func _ready() -> void:
	if lado:
		rayOficial = rayLado
		return
	rayOficial = rayBaixo
	pass

func _process(_delta: float) -> void:
	if _sobrou:
		_completed = true
		#print("completed " + str(id))
		return
	if rayOficial.is_colliding():
		var node = rayOficial.get_collider()
		if node.has_method("get_cavalete_id"):
			if node.get_cavalete_id() == need_id:
				_completed = true
			else:
				_completed = false
	else:
		_completed = false
		pass
	#print("completed " + str(id))
	pass

func keep_holding():
	if player:
		# Atualiza a posição do barril para manter o deslocamento relativo ao jogador
		global_position = player.global_position + offset

func Interaction():
	player = Global.player
	if player.holding && !player_holding:
		return
	if player_holding:
		player.current_state = player.PlayerState.NORMAL
		player_holding = false
		player._can_run = true
		player.holding = false
		collision_mask = 2
		collision_layer = 2
	else:
		# Define o deslocamento inicial quando o barril é pegado
		offset = global_position - player.global_position
		player.current_state = player.PlayerState.PUSH
		player.holding = true
		player_holding = true
		player._can_run = false
		collision_mask = 0
		collision_layer = 0
