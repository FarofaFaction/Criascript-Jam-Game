extends Node

@export var initial_state : State
var current_state: State
var states : Dictionary  = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
		pass
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.Update()
	pass

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update()
	pass

func on_child_transition(state: State, new_state_name: String):
	if	current_state is not State:
		return
	var new_state = states.get(new_state_name.to_lower())
	if (!new_state):
		print("State not found")
		return
	if (current_state):
		current_state.Exit()
	new_state.Enter()
	current_state = new_state
	pass
