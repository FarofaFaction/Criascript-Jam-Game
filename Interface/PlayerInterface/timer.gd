extends Control
class_name  Watch

# Variables to control the time
@onready var TimeLabel : Label = $TimeLabel
@onready var timer = set_time(18, 0)
var total_time: float = 0.0
@export var seconds_per_minute: float = 60 * 8  # 8 hours in seconds (480 seconds) for 1 minute of gameplay
@export var timestop := true
var hours: int
var minutes: int
var seconds: int

func _run_clock(_delta: float):
	total_time += (_delta * seconds_per_minute)

	hours = int(total_time / 3600) % 24
	minutes = int(int(total_time) % 3600 / 60)
	seconds = int(int(total_time) % 60)
	# Format the time
	TimeLabel.text = "%02d:%02d" % [hours, minutes]
	TimeLabel.text = "%02d:%02d:%02d" % [hours, minutes, seconds]
	pass

func start():
	timestop = false
	pass

func stop():
	timestop = true

#tempo real speed = 1
#1 minuto por segundo = 60
#x horas em um minuto = 60 * x
func set_speed(speed: int):
	seconds_per_minute = speed

func _process(_delta: float) -> void:
	if (!timestop):
		_run_clock(_delta)

func set_time(hour: int, minute: int):
	var total_seconds: int = (hour * 3600) + (minute * 60)

	total_time = float(total_seconds)

	var hours: int = int(total_time / 3600) % 24
	var minutes: int = int(int(total_time) % 3600 / 60)
	TimeLabel.text = "%02d:%02d" % [hours, minutes]
