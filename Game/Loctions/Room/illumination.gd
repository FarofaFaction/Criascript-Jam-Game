extends Node2D

var on_night := false
@export var switchAudioPlayer : AudioStreamPlayer2D
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
	set_process(false)
	await  get_tree().create_timer(0.1).timeout
	#print(GlobalTimer.hours)
	if GlobalTimer.hours >= light_off_time or GlobalTimer.hours < light_on_time:
		#print(GlobalTimer.hours)
		GlobalIllumination.color = color_night
		BigLight.color.a = 0
		SmallLight.color.a = 0
		on_night = true
	else:
		GlobalIllumination.color = color_day
		BigLight.color.a = 1
		SmallLight.color.a = 1
		on_night = false
	set_process(true)



## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	check_ilumination()
	pass

func turn_light_off():
	if (!GlobalIllumination || !BigLight || !SmallLight):
		return
	if switchAudioPlayer:
		switchAudioPlayer.play()
		await get_tree().create_timer(1.1).timeout
	var color: Color = BigLight.color
	color.a = 0
	var tween = create_tween()
	#tween.set_parallel(true)
	if GlobalIllumination:
		tween.tween_property(GlobalIllumination, "color", color_night, 0)
	BigLight.color.a = 0
	SmallLight.color.a = 0
	#tween.tween_property(BigLight, "color", color, 1)
	#tween.tween_property(SmallLight, "color", color, 1)
		#tween.tween_property(GlobalIllumination, "color", color_day, 2)
	on_night = true
	pass

func turn_light_on():
	if (!GlobalIllumination || !BigLight || !SmallLight):
		return
	if switchAudioPlayer:
		switchAudioPlayer.play()
		await get_tree().create_timer(1.1).timeout
	var color: Color = BigLight.color
	color.a = 1
	var tween = create_tween()
	#tween.set_parallel(true)
	if GlobalIllumination:
		tween.tween_property(GlobalIllumination, "color", color_day, 0)
	BigLight.color.a = 1
	SmallLight.color.a = 1
	#tween.tween_property(BigLight, "color", color, 1)
	#tween.tween_property(SmallLight, "color", color, 1)
		#tween.tween_property(GlobalIllumination, "color", color_night, 2)
	on_night = false
	pass

func check_ilumination():
	if (!BigLight || !SmallLight):
		return
	if GlobalTimer.is_time(light_on_time,0):
		turn_light_on()
	if GlobalTimer.is_time(light_off_time,0):
		turn_light_off()
	pass
