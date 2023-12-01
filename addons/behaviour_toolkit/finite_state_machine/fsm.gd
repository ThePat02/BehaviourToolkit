@tool
@icon("res://addons/behaviour_toolkit/icons/FiniteStateMachine.svg")
class_name FiniteStateMachine extends BehaviourToolkit
## An implementation of a simple finite state machine.
##
## The Finite State Machine is composed of states [FSMState] and transitions 
## [FSMTransition] nodes.
## This is the class to handle all states and their transitions.
## On ready, all FSMTransition child nodes will be set up as transitions.
## To implement your logic you can override the [code]_on_enter, _on_update and
## _on_exit[/code] methods when extending the node's script.
## [br][br]
## The current active state in FSM is usually changed by [FSMTransition] node,
## but you can control state change from THE code using
## [method FiniteStateMachine.change_state].
## [br][br]
## If you wish to add, remove, move [FSMState] nodes at run-time first add new
## [FSMStates] stop the FSM with [method FiniteStateMachine.exit_active_state_and_stop]
## and re-start it with method [method FiniteStateMachine.start] providing one
## of the new states either as start method property or change
## [member FiniteStateMachine.initial_state] before running [code]start()[/code].
## After this procedure you can delete unused states.


enum ProcessType {
	IDLE, ## Updates on every rendered frame (at current FPS).
	PHYSICS, ## Updates on a fixed rate (60 FPS by default) synchornized with physics thread. 
}


const ERROR_START_STATE_NULL: String = "The started state is a null."


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

## The initial state of the FSM.
@export var initial_state: FSMState:
	set(value):
		initial_state = value
		update_configuration_warnings()
## The actor of the FSM.
@export var actor: Node
## The blackboard of the FSM.
@export var blackboard: Blackboard


## Whether the FSM is active or not.[br]
## To activate use the [code]start()[/code] method.
var active: bool = false
## The list of states in the FSM.
var states: Array[FSMState]
## The current active state.
var active_state: FSMState
## The list of current events.
var current_events: Array[String]
## Current BT BTStatus
var current_bt_status: BTBehaviour.BTStatus


# Connecting signal using @onready to omit the need to use super() call
# in _ready() of extended nodes if they override _ready().
@onready var __connect_child_order_changed: int = \
	child_order_changed.connect(_update_states_list)


func _validate_property(property: Dictionary) -> void:
	if property.name == "autostart" and get_parent() is BTIntegratedFSM:
		autostart = false
		property.usage = PROPERTY_USAGE_NO_EDITOR
	elif property.name == "active":
		property.usage = PROPERTY_USAGE_READ_ONLY


func _ready() -> void:
	set_physics_process(false)
	set_process(false)

	# Don't run in editor
	if Engine.is_editor_hint():
		return
	
	_update_states_list()
	
	if blackboard == null:
		blackboard = _create_local_blackboard()
	
	if states.is_empty() or initial_state == null:
		return
	
	if autostart:
		start(initial_state)
	
	if not process_type:
		process_type = ProcessType.PHYSICS
	
	_setup_processing()


func  _physics_process(delta: float) -> void:
	_process_code(delta)


func _process(delta: float) -> void:
	_process_code(delta)


func _process_code(delta: float) -> void:
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


## Start FSM with given state, if no state is provided [code]initial_state[/code]
## property will be used.
func start(state: FSMState = initial_state) -> void:
	assert(state != null, ERROR_START_STATE_NULL)
	
	current_bt_status = BTBehaviour.BTStatus.RUNNING
	
	active = true
	
	active_state = state
	active_state._on_enter(actor, blackboard)
	
	# Enable processing
	_setup_processing()
	
	# Emit the state changed signal
	emit_signal("state_changed", active_state)



## Changes the current state and calls the appropriate methods like
## [code]_on_exit()[/code] and [code]_on_enter()[/code] for respective states.
func change_state(state: FSMState) -> void:
	# Exit the current state
	active_state._on_exit(actor, blackboard)
	
	# Change the current state
	active_state = state
	
	# Enter the new state
	active_state._on_enter(actor, blackboard)
	
	# Emit the state changed signal
	emit_signal("state_changed", active_state)


## Exits currenlty active state effectively stopping FSM, makes
## [code]active_state[/code] property [code]null[/code].
func exit_active_state_and_stop() -> void:
	# Exit the current state
	active_state._on_exit(actor, blackboard)
	
	active_state = null
	active = false
	
	# Stop processing
	set_physics_process(false)
	set_process(false)
	
	# Emit the state changed signal
	emit_signal("state_changed", active_state)


## Fires an event in the FSM if the FSM is active.
func fire_event(event: String) -> void:
	if active == false:
		return
	
	current_events.append(event)


func _update_states_list() -> void:
	if Engine.is_editor_hint():
		return
	
	states.clear()
	for state in get_children():
		if state is FSMState:
			states.append(state)


func _create_local_blackboard() -> Blackboard:
	var blackboard: Blackboard = Blackboard.new()
	return blackboard


# Configures process type to use, if FSM is not active both are disabled.
func _setup_processing() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process(false)
		return
	
	if active:
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
