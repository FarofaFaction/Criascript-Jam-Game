extends Control

# Variables to control the time
@onready var TimeLabel : Label = $TimeLabel
@onready var timer = set_time(18, 0)
var total_time: float = 0.0
var seconds_per_minute: float = 60 * 8  # 8 hours in seconds (480 seconds) for 1 minute of gameplay
var timestop := true

func _run_clock():
	# Increment total time based on delta
	total_time += (0.016 * seconds_per_minute)
	
	# Calculate hours, minutes, and seconds
	var hours: int = int(total_time / 3600) % 24
	var minutes: int = int(int(total_time) % 3600 / 60)
	#var seconds: int = int(int(total_time) % 60)
	# Format the time
	TimeLabel.text = "%02d:%02d" % [hours, minutes]
	pass

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Run")):
		timestop = false
	if (!timestop):
		TimeLabel.visible = true
		_run_clock()
	else:
		TimeLabel.visible = false

# Function to set the time
func set_time(hour: int, minute: int):
	# Converte as horas e minutos em segundos
	var total_seconds: int = (hour * 3600) + (minute * 60)
	
	# Ajusta total_time
	total_time = float(total_seconds)

	# Atualiza o display
	var hours: int = int(total_time / 3600) % 24
	var minutes: int = int(int(total_time) % 3600 / 60)
	TimeLabel.text = "%02d:%02d" % [hours, minutes]
