extends Control
class_name  Watch

# Variables to control the time
var text: String
var total_time: float = 0.0
var seconds_per_minute: float = 60 * 8  # 8 hours in seconds (480 seconds) for 1 minute of gameplay
#var timestop := true
var timestop := false
var hours: int
var minutes: int
var seconds: int

func _ready() -> void:
	set_time(18, 0)
	pass
	
func _run_clock(_delta: float):
	total_time += (_delta * seconds_per_minute)

	hours = int(total_time / 3600) % 24
	minutes = int(int(total_time) % 3600 / 60)
	seconds = int(int(total_time) % 60)
	# Format the time
	text = "%02d:%02d" % [hours, minutes]
	#text = "%02d:%02d:%02d" % [hours, minutes, seconds]
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

	hours = int(total_time / 3600) % 24
	minutes = int(int(total_time) % 3600 / 60)
	text = "%02d:%02d" % [hours, minutes]