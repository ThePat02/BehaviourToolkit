@icon("res://addons/behaviour_toolkit/icons/FiniteStateMachine.svg")
class_name FiniteStateMachine extends BehaviourToolkit
## An implementation of a simple finite state machine.
##
## The Finite State Machine is composed of states and transitions.


const ERROR_INITIAL_STATE_NULL: String = "The initial cannot be null when starting the State Machine."


## The signal emitted when the state changes.
signal state_changed(state: FSMState)


## Whether the FSM should start automatically.
@export var autostart: bool = false
## Whether the FSM is active or not.
@export var active: bool = true
## Process mode the FSM should run in.
@export var process_type: ProcessType = ProcessType.PHYSICS
## The initial state of the FSM.
@export var initial_state: FSMState

## The actor of the FSM.
@export var actor: Node
## The blackboard of the FSM.
@export var blackboard: Blackboard


## The list of states in the FSM.
var states: Array[FSMState]
## The current active state.
var active_state: FSMState
## The list of current events.
var current_events: Array[String]
## Current BT Status
var current_bt_status: BTLeaf.Status


func _ready() -> void:
	connect("state_changed", _on_state_changed)

	if blackboard == null:
		blackboard = _create_local_blackboard()

	if autostart:
		start()
	else:
		active = false


func start() -> void:
	current_bt_status = BTLeaf.Status.RUNNING
	
	# Check if the initial state is valid
	assert(initial_state != null, ERROR_INITIAL_STATE_NULL)

	# Get all the states
	for state in get_children():
		if state is FSMState:
			states.append(state)

	active = true

	# Set the initial state
	active_state = initial_state
	active_state._on_enter(actor, blackboard)

	# Emit the state changed signal
	emit_signal("state_changed", active_state)


func _process(_delta) -> void:
	if not active:
		return
	
	if not process_type == ProcessType.IDLE:
		return
	
	tick()


func _physics_process(_delta):
	if not active:
		return
	
	if not process_type == ProcessType.PHYSICS:
		return
	
	tick()


func tick():
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
		if transition.is_valid(actor, blackboard) or transition.is_valid_event(event):
			# Process the transition
			transition._on_transition(actor, blackboard)
			
			# Change the current state
			change_state(transition.get_next_state())

			break
	
	# Process the current state
	active_state._on_update(actor, blackboard)


## Changes the current state and calls the appropriate methods like _on_exit and _on_enter.
func change_state(state: FSMState) -> void:
	# Exit the current state
	active_state._on_exit(actor, blackboard)

	# Change the current state
	active_state = state

	# Enter the new state
	active_state._on_enter(actor, blackboard)

	# Emit the state changed signal
	emit_signal("state_changed", active_state)


## Fires an event in the FSM.
func fire_event(event: String) -> void:
	current_events.append(event)


func _create_local_blackboard() -> Blackboard:
	var blackboard: Blackboard = Blackboard.new()
	return blackboard


func _on_state_changed(state: FSMState) -> void:
	pass
