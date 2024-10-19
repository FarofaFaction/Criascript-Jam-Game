extends Node2D

@export var player : PlayerClass
@onready var area1 := $InteractibleArea
@onready var area2 := $InteractibleArea2
@export var mark1 : Marker2D
@export var mark2 : Marker2D
@export var markUp : Marker2D
@export var markDown : Marker2D
@export var timer : Timer
@export var animation_player : AnimationPlayer

func _process(_delta: float) -> void:
	#animation_player.play()
	pass

func start_timer():
	# Defina um intervalo aleatório entre 2 e 4 segundos
	var random_time = randf_range(4, 6)
	timer.wait_time = random_time
	timer.start()

func _on_Timer_timeout():
	# Tocar a animação
	animation_player.play("CorridorLight")
	# Reinicie o temporizador
	start_timer()


func _ready() -> void:
	start_timer()
	# Conectando sinais de entrada e saída das áreas
	area1.body_entered.connect(_on_area1_body_entered)
	area1.body_exited.connect(_on_area1_body_exited)
	area2.body_entered.connect(_on_area2_body_entered)
	area2.body_exited.connect(_on_area2_body_exited)

func _on_area1_body_entered(body):
	if body == player:
		#animation_player.play("CorridorLight")
		#await  animation_player.animation_finished
		player.global_position.x = mark2.global_position.x

func _on_area1_body_exited(body):
	if body == player:
		pass

func _on_area2_body_entered(body):
	if body == player:
		#animation_player.play("CorridorLight")
		#await  animation_player.animation_finished
		
		#player.get_node("Camera").position_smoothing_enabled = false
		player.global_position.x = mark1.global_position.x

func _on_area2_body_exited(body):
	if body == player:
		pass


func _on_up_body_entered(body: Node2D) -> void:
	if body == player:
		player.global_position.y = markDown.global_position.y
	pass # Replace with function body.


func _on_down_body_entered(body: Node2D) -> void:
	if body == player:
		player.global_position.y = markUp.global_position.y
	pass # Replace with function body.
