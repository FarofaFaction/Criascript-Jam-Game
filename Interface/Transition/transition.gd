extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

signal on_transition_finished

func _ready() -> void:
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	pass

func _on_animation_finished(anim_name):
	on_transition_finished.emit()
	color_rect.visible = false
	pass

func transition(anim_name : String):
	color_rect.visible = true
	if (anim_name == "fade_to_black"):
		animation_player.play("fade_to_black")
	elif (anim_name == "fade_out_black"):
		animation_player.play("fade_out_black")
	else:
		print("Transition Not Found")
		on_transition_finished.emit()
	pass
