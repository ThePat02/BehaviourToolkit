@tool
@icon("res://addons/behaviour_toolkit/icons/FiniteStateMachine.svg")
class_name FiniteStateMachine extends BehaviourToolkit
## An implementation of a simple finite state machine.
##
## The Finite State Machine is composed of states and transitions.
## This is the class to handle all states and their transitions.
## On ready, all FSMTransition child nodes will be set up as transitions.
## To implement your logic you can override the [code]_on_enter, _on_update and
## _on_exit[/code] methods when extending the node's script.


enum ProcessType {
	IDLE, ## Updates on every rendered frame (at current FPS).
	PHYSICS, ## Updates on a fixed rate (60 FPS by default) synchornized with physics thread. 
}


const ERROR_INITIAL_STATE_NULL: String = "The initial cannot be null when starting the State Machine."


## The signal emitted when the state changes.
signal state_changed(state: FSMState)


## Whether the FSM should start automatically.
@export var autostart: bool = false

## Can be used to select if FSM _on_update() is calculated on
## rendering (IDLE) frame or physics (PHYSICS) frame.
## [br]
## More info: [method Node._process] and [method Node._physics_process]
@export var process_type: ProcessType = ProcessType.PHYSICS:
	set(value):
		process_type = value
		_setup_processing()

## Whether the FSM is active or not.
@export var active: bool = true
## The initial state of the FSM.
@export var initial_state: FSMState:
	set(value):
		initial_state = value
		update_configuration_warnings()
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
## Current BT BTStatus
var current_bt_status: BTBehaviour.BTStatus


func _ready() -> void:
	# Don't run in editor
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process(false)
		return

	connect("state_changed", _on_state_changed)

	if blackboard == null:
		blackboard = _create_local_blackboard()

	if autostart:
		start()
	else:
		active = false

	if not process_type:
		process_type = ProcessType.PHYSICS

	_setup_processing()


func start() -> void:
	current_bt_status = BTBehaviour.BTStatus.RUNNING
	
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


func  _physics_process(delta: float) -> void:
	_process_code(delta)


func _process(delta: float) -> void:
	_process_code(delta)


func _process_code(delta: float) -> void:
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
		if transition.is_valid(actor, blackboard) or transition.is_valid_event(event):
			# Process the transition
			transition._on_transition(delta, actor, blackboard)
			
			# Change the current state
			change_state(transition.get_next_state())

			break
	
	# Process the current state
	active_state._on_update(delta, actor, blackboard)


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


# Configures process type to use, if FSM is not active both are disabled.
func _setup_processing() -> void:
	set_physics_process(process_type == ProcessType.PHYSICS)
	set_process(process_type == ProcessType.IDLE)


func _on_state_changed(state: FSMState) -> void:
	pass


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	if not initial_state:
		warnings.append("Initial state is not set.")
	
	var children: Array = get_children()

	if children.size() == 0:
		warnings.append("No states found.")

	for child in children:
		if not child is FSMState:
			warnings.append("Node '" + child.get_name() + "' is not a FSMState.")

	return warnings
