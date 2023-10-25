@icon("res://addons/behaviour_toolkit/icons/FSMTransition.svg")
class_name FSMTransition extends BehaviourToolkit
## A transition between two [FSMState]s in a [FiniteStateMachine].


## The state to transition to.
@export var next_state: FSMState

@export_category("Transition Logic")
## If true, the FSM will check for the event to trigger the transition.
@export var use_event: bool = false
## The event that triggers the transition.
@export var event: String = ""


## Executed when the transition is taken.
func _on_transition(_actor: Node, _blackboard: Blackboard) -> void:
	pass


## Evaluates true, if the transition conditions are met.
func is_valid(_actor: Node, _blackboard: Blackboard) -> bool:
	return false


func is_valid_event(current_event: String) -> bool:
	if current_event == "":
		return false
	
	return current_event == event


## Returns which state to transition to, when valid.
func get_next_state() -> FSMState:
	return next_state
