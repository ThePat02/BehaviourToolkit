@tool
@icon("res://addons/behaviour_toolkit/icons/FSMTransition.svg")
class_name FSMTransition extends BehaviourToolkit
## A transition between two [FSMState]s in a [FiniteStateMachine].
##
## This is the base class for all transitions. To implement your logic you can
## override the [code]_on_transition[/code] method when extending the node's
## script.[br]
## To setup custom conditions you can override the is_valid method.[br]
## If you want to use events to trigger the transition, set
## [code]use_event[/code] to true and set the event property to the name
## of the event you want to listen for.

## The state to transition to.
@export var next_state: FSMState:
	set(value):
		next_state = value
		update_configuration_warnings()

@export_category("Transition Logic")

## Always transition, ignoring `is_valid()` or any events.
@export var always_transition: bool = false:
	set(value):
		always_transition = value
		notify_property_list_changed()
		update_configuration_warnings()


# Rather than using @export on these properties, we include them here so we can show them conditionally.
func _get_property_list() -> Array[Dictionary]:
	var property_list: Array[Dictionary] = []

	if not always_transition:
		property_list.append({"name": "use_event", "type": TYPE_BOOL})
		property_list.append({"name": "event", "type": TYPE_STRING})

	return property_list


## If true, the FSM will check for the event to trigger the transition.
var use_event: bool = false:
	set(value):
		use_event = value
		update_configuration_warnings()

## The event that triggers the transition.
var event: String = "":
	set(value):
		event = value
		update_configuration_warnings()


## Executed when the transition is taken.
func _on_transition(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	pass


## Evaluates true, if the transition conditions are met.
func is_valid(_actor: Node, _blackboard: Blackboard) -> bool:
	if always_transition:
		return true

	return false


func is_valid_event(current_event: String) -> bool:
	if current_event == "":
		return false

	return current_event == event


## Returns which state to transition to, when valid.
func get_next_state() -> FSMState:
	return next_state


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	var parent: Node = get_parent()
	if not parent is FSMState:
		warnings.append("FSMTransition should be a child of FSMState.")

	if not next_state:
		warnings.append("FSMTransition has no next state.")

	if use_event and event == "":
		warnings.append("FSMTransition has no event set.")

	return warnings
