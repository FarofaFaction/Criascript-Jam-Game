extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

signal on_transition_finished

func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	pass

func _on_animation_finished(_anim_name): #O signal recebido precisa desse parametro, mesmo que eu nao use
	on_transition_finished.emit()
	color_rect.visible = false
	pass

func transition(anim_name : String):
	color_rect.visible = true
	animation_player.play(anim_name)
	pass
