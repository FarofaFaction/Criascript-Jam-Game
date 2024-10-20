extends State

var start_wait := 5.0
var save_speed : float
@export var key : Node2D
@export var Bola : Area2D
@export var pacient : Pacient
@export var startBolaPosition : Marker2D
@export var navigation_agent : NavigationAgent2D 
var PlayerPoints := 0
var BolaVelocity := Vector2.ZERO
var zoom_init := Vector2(3,3)
var zoom_final := Vector2(5,5)
var offset_init := Vector2(-100,0)
var offset_final := Vector2(0,0)
var on_bola := false

func Enter():
	if !pacient:
		return
	save_speed = pacient.speed
	pacient.speed = 135
	Bola.visible = true
	if Global.player:
		var twee = create_tween()
		twee.set_parallel()
		twee.tween_property(Global.player.camera, "zoom", zoom_init, 3)
		twee.tween_property(Global.player.camera, "offset", offset_init, 3)
	await  get_tree().create_timer(start_wait).timeout
	reset_bola()
	navigation_agent.set_target_position(pacient.target_area.global_position)
	#pacient.visible = false

func Exit():
	if !pacient:
		return
	pacient.speed = save_speed
	Bola.visible = false
	Dialogic.VAR.DesafianteExterna.PartidaComeçou = false
	if Global.player:
		var twee = create_tween()
		twee.set_parallel()
		twee.tween_property(Global.player.camera, "zoom", zoom_final, 3)
		twee.tween_property(Global.player.camera, "offset", offset_final, 3)
	pass

func Update():
	if !pacient:
		return
	if PlayerPoints >= 3:
		Dialogic.VAR.DesafianteExterna.Venceu = true
		if is_instance_valid(key):
			key.global_position = pacient.global_position
			key.visible = true
		Transitioned.emit(self, "PacientWalkout")
	if GlobalTimer.time_passed(pacient.hour_to_sleep):
		Transitioned.emit(self, "PacientWalkout")
	pass

func Physics_Update():
	if !pacient:
		return
	move_pacient()
	Bola.global_position += BolaVelocity
	pass

func move_pacient():
	if !on_bola:
		var target_position = pacient.target_area.global_position

		if pacient.global_position.distance_to(target_position) > 35:
			navigation_agent.set_target_position(target_position)
			var next_point = navigation_agent.get_next_path_position()
			if next_point:
				pacient.velocity = (next_point - pacient.global_position).normalized() * pacient.speed
		else:
			on_bola = true
	else:
		var target_position = Bola.global_position

		if pacient.global_position.distance_to(target_position) > 35:
			navigation_agent.set_target_position(target_position)
		var next_point = navigation_agent.get_next_path_position()
		if next_point:
			pacient.velocity = (next_point - pacient.global_position).normalized() * pacient.speed
			#if pacient.velocity.y < 0.5 && pacient.velocity.y >= 0:
				#pacient.velocity.y = 0.5
			#if pacient.velocity.y > -0.5 && pacient.velocity.y >= 0:
				#pacient.velocity.y = -0.5
			pacient.velocity.x = 0
		else:
			on_bola = true
	pass

func reset_bola():
	BolaVelocity.y = randf_range(1.0, 2.0)
	BolaVelocity.x = 2.3
	Bola.global_position = startBolaPosition.global_position
	pass

func _on_gol_esquerdo_area_entered(area: Area2D) -> void:
	if area.name != "Bola":
		return
	PlayerPoints += 1
	reset_bola()
	pass # Replace with function body.


func _on_gol_direito_area_entered(area: Area2D) -> void:
	if area.name != "Bola":
		return
	if Global.player:
		Global.player.take_damage(25)
	reset_bola()
	pass # Replace with function body.


func _on_barreira_em_cima_area_entered(area: Area2D) -> void:
	if area.name != "Bola":
		return
	BolaVelocity.y *= -1
	pass # Replace with function body.


func _on_barreira_em_baixo_area_entered(area: Area2D) -> void:
	if area.name != "Bola":
		return
	BolaVelocity.y *= -1
	pass # Replace with function body.


func _on_pe_direito_area_entered(area: Area2D) -> void:
	if area.name != "Bola":
		return
	BolaVelocity.x *= -1
	pass # Replace with function body.


func _on_pe_esquerdo_area_entered(area: Area2D) -> void:
	if area.name != "Bola":
		return
	BolaVelocity.x *= -1
	pass # Replace with function body.
