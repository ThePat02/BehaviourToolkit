## @experimental: As an experimental feature, this may still contain bugs. 
## Please be aware that its API and functionality are subject to change in future updates.
@tool
extends FSMState
class_name NestedFSM

## An implementation of a simple finite state machine.
##
## The Nested Finite State Machine is a state that contains a FiniteStateMachine insde
## This instanced FiniteStateMachine inherits values from the parent FiniteStateMachine.
## On ready, the NestedFSM will reparent each child that is an FSMState or NestedFSM to the new FiniteStateMachine.
## To implement your logic you can override the _on_enter, _on_update and
## _on_exit methods when extending the node's script.


## The signal emitted when the fsm's state changes.
signal nested_state_changed(state: FSMState)

@export var initial_state : FSMState
@export var verbose : bool

# Create a child FSM instance to manage the nested states
@onready var fsm = FiniteStateMachine.new()

func _ready() -> void:
	super()
	
	if Engine.is_editor_hint():
		return
	
	# Find all direct child nodes that are FSMStates
	var nested_states : Array[Node] = get_children().filter(func(n): return n is FSMState)
	# Find all direct child nodes that are NestedFSMs (for hierarchical nesting)
	var nested_fsms : Array[Node] = get_children().filter(func(n): return n is NestedFSM)
	
	# Add the FSM container as a child node, and rename it for clarity in scene tree
	add_child(fsm)
	fsm.name = "NestedFSM"
	
	# Move all FSMState children to the internal FSM container
	for state in nested_states: 
		state.reparent(fsm)
		
	# Move all nested FSMs to the internal FSM container
	for nested_fsm in nested_fsms: 
		nested_fsm.reparent(fsm)
		
	# Configure the internal FSM
	fsm.initial_state = initial_state  # Set the starting state
	fsm.verbose = verbose              # Set debug output preference
	
	# Get reference to the parent state machine
	# After reparenting, our parent should always be a FiniteStateMachine
	# (either the root FSM or another NestedFSM's internal FSM)
	var parent_state_machine : FiniteStateMachine = get_parent()
		 
	# Share resources with the parent FSM
	fsm.actor = parent_state_machine.actor           # Share the actor reference
	fsm.process_type = parent_state_machine.process_type  # Share process type (physics/idle)
	fsm.blackboard = parent_state_machine.blackboard     # Share the blackboard (shared data)
	
	# Connect the internal FSM's state_changed signal to our nested_state_changed signal
	fsm.state_changed.connect(func(state: FSMState): nested_state_changed.emit(state))

# Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	fsm.start()

# Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	fsm.active = false

# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	warnings.append_array(super._get_configuration_warnings())
	
	var parent: Node = get_parent()
	if not parent is FiniteStateMachine:
		warnings.append("NestedFSM should be a child of a FiniteStateMachine node.")
	
	if not initial_state:
		warnings.append("FSM needs an initial state")
		return warnings  # Return early if no initial state
	
	var fsm := _find_fsm()
	if fsm and initial_state:
		# check if initial_state is a descendant of this FSM
		if not is_ancestor_of(initial_state):
			warnings.append("Don't select initial state outside of this FSM")
	
	return warnings

func _find_fsm() -> FiniteStateMachine:
	var current: Node = self
	while current:
		if current is FiniteStateMachine:
			return current as FiniteStateMachine
		current = current.get_parent()
	return null
