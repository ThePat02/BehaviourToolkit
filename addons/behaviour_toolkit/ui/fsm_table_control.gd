@tool
class_name FSMTableControl extends GridContainer

@export var fsm: FiniteStateMachine

const FsmTransitionControl = preload("./fsm_transition_control.gd")


# ###########################
#   Lifecycle callbacks
# ###########################
func _ready():
	if fsm:
		set_finite_state_machine(fsm)


# ###########################
#   Public instance methods
# ###########################

## Sets the FiniteStateMachine this control should edit.
func set_finite_state_machine(new_machine: FiniteStateMachine) -> void:
	fsm = new_machine

	_clear_children()
	if not fsm:
		return

	var events := _find_events(fsm)

	columns = events.size() + 1

	var states_label := Label.new()
	states_label.text = "States"
	add_child(states_label)

	for event in events:
		var event_label := _create_event_label(event)
		add_child(event_label)

	for state in _find_states(fsm):
		var state_label := _create_state_label(state)
		add_child(state_label)

		var state_transitions := {}
		for child in _find_transitions(state):
			state_transitions[_get_transition_event_key(child)] = child

		for event in events:
			var transition: FSMTransition = state_transitions.get(event, null)
			var transition_edit_control := _create_transition_edit_control(transition, state, event)
			add_child(transition_edit_control)

# ##########################
#   private utility
# ##########################
func _clear_children():
	for child in get_children():
		child.queue_free()


# ##########################
#   Factory functions
# ##########################

## Creates a transition edit control
##
## transition: The existing transition the control is to manipulate, if any.
## state: The 'from' state the transition belongs to. if `transition` is `null`, a new transition will be added to this state.
## event: An 'event key'. Either the name of the event that should be assigned to `transition.event`, or the path to the script
##        that is attached to the transition node.
func _create_transition_edit_control(transition: FSMTransition, state: FSMState, event: StringName) -> FsmTransitionControl:
	var control := FsmTransitionControl.new()
	control.placeholder_text = "<null>"
	control.transition = transition
	control.state = state
	control.event = event
	return control


## Creates a header label for an events.
func _create_event_label(event: StringName) -> Label:
	var event_label := Label.new()
	if event.begins_with("res://"):
		event_label.text = event.rsplit("/", false, 1)[1]
	else:
		event_label.text = event
	return event_label


## Creates a header label for a state.
func _create_state_label(state: FSMState) -> Label:
	var state_label := Label.new()
	state_label.text = state.name
	return state_label


## Creates a normalized event name for a transition.
func _get_transition_event_key(transition: FSMTransition) -> StringName:
	if transition.use_event:
		return transition.event
	else:
		return transition.get_script().resource_path


# ##########################
#   Filters
# ##########################

## Finds all the normalized event names for a FiniteStateMachine
func _find_events(fsm: FiniteStateMachine) -> Array[StringName]:
	var seen: Dictionary = {}
	for child_state in _find_states(fsm):
		for child in _find_transitions(child_state):
			seen[_get_transition_event_key(child)] = true

	var event_keys: Array[StringName] = []
	event_keys.assign(seen.keys())
	return event_keys


## Finds all state nodes belonging to a FiniteStateMachine
func _find_states(fsm: FiniteStateMachine) -> Array:
	return fsm.get_children().filter(func (ch): return ch is FSMState)


## Finds all transition nodes belonging to an FSMState
func _find_transitions(state: FSMState) -> Array:
	return state.get_children().filter(func (ch): return ch is FSMTransition)
