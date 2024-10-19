extends AnimatedSprite2D

var parent : Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	if !parent:
		queue_free()
		return
	if !(parent is AnimatedSprite2D):
		parent.remove_child.call_deferred(self)
		queue_free()
		return
	self.sprite_frames = parent.sprite_frames
	parent.animation_changed.connect(change_animation)
	parent.frame_changed.connect(change_frame)
	change_animation()
	change_frame()
	pass # Replace with function body.

func change_animation():
	animation = parent.animation
	pass

func change_frame():
	frame = parent.frame
	pass

func _process(_delta: float) -> void:
	flip_h = parent.flip_h
	
