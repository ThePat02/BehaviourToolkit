@icon("res://addons/behaviour_toolkit/icons/FiniteStateMachine.svg")
class_name FiniteStateMachine extends BehaviourToolkit
## An implementation of a simple finite state machine.
##
## The Finite State Machine is composed of states and transitions.


## The signal emitted when the state changes.
signal state_changed(state: FSMState)


## Whether the FSM should start automatically.
@export var autostart: bool = true
## Whether the FSM is active or not.
@export var active: bool = true
## The initial state of the FSM.
@export var initial_state: FSMState

@export var actor: Node
@export var blackboard: Blackboard


## The list of states in the FSM.
var states: Array[FSMState]
## The current active state.
var active_state: FSMState
## The list of current events.
var current_events: Array[String]


func _ready() -> void:
	if autostart:
		start()
	else:
		active = false


func start() -> void:
	# Get all the states
	for state in get_children():
		if state is FSMState:
			states.append(state)

	active = true

	# Set the initial state
	active_state = initial_state
	active_state._on_enter()

	# Emit the state changed signal
	emit_signal("state_changed", active_state)


func _process(_delta) -> void:
	if not active:
		return

	# Check if there are states
	if states.size() == 0:
		return
	
	# The current event
	var event: String = ""

	# Check if there are events
	if current_events.size() > 0:
		# Get the first event
		event = current_events[0]
		# Remove the event from the list
		current_events.remove_at(0)

	# Check if the current state is valid
	for transition in active_state.transitions:
		if transition.is_valid() or transition.is_valid_event(event):
			# Process the transition
			transition._on_transition()
			
			# Change the current state
			change_state(transition.get_next_state())

			break
	
	# Process the current state
	active_state._on_update()


## Changes the current state and calls the appropriate methods like _on_exit and _on_enter.
func change_state(state: FSMState) -> void:
	# Exit the current state
	active_state._on_exit()

	# Change the current state
	active_state = state

	# Enter the new state
	active_state._on_enter()

	# Emit the state changed signal
	emit_signal("state_changed", active_state)


## Fires an event in the FSM.
func fire_event(event: String) -> void:
	current_events.append(event)
