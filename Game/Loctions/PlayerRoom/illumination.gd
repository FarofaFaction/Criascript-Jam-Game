extends Node2D

@export var color_night : Color
@export var color_day : Color
@export var light_off_time := 20
@export var light_on_time := 6
@export var ilumination_node := Node2D
@export var BigLight : PointLight2D
@export var SmallLight : PointLight2D
@export var GlobalIllumination : PointLight2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTimer.time_changed.connect(check_ilumination)
	if GlobalTimer.time_passed(Vector2(light_off_time, 0)) || GlobalTimer.hours < light_on_time:
		GlobalIllumination.color = color_night
		BigLight.color.a = 0
		SmallLight.color.a = 0
		pass
	else:
		GlobalIllumination.color = color_day
		BigLight.color.a = 1
		SmallLight.color.a = 1
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#
	#pass

func turn_light_off():
	if (!GlobalIllumination || !BigLight || !SmallLight):
		return
	var color: Color = BigLight.color
	color.a = 0
	var tween = create_tween()
	if GlobalIllumination:
		tween.tween_property(GlobalIllumination, "color", color_night, 2)
	tween.tween_property(BigLight, "color", color, 2)
	tween.tween_property(SmallLight, "color", color, 2)
		#tween.tween_property(GlobalIllumination, "color", color_day, 2)
	pass

func turn_light_on():
	if (!GlobalIllumination || !BigLight || !SmallLight):
		return
	var color: Color = BigLight.color
	color.a = 1
	var tween = create_tween()
	if GlobalIllumination:
		tween.tween_property(GlobalIllumination, "color", color_day, 2)
	tween.tween_property(BigLight, "color", color, 2)
	tween.tween_property(SmallLight, "color", color, 2)
		#tween.tween_property(GlobalIllumination, "color", color_night, 2)
	pass

func check_ilumination():
	if (!BigLight || !SmallLight):
		return
	if GlobalTimer.is_time(light_on_time,0):
		turn_light_on()
	if GlobalTimer.is_time(light_off_time,0):
		turn_light_off()
	pass
