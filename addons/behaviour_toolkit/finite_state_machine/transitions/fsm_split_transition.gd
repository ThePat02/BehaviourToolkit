@tool
@icon("res://addons/behaviour_toolkit/icons/FSMSplitTransition.svg")
class_name FSMSplitTransition extends FSMTransition

## The state to transition to.
@export var next_state_true: FSMState:
	set(value):
		next_state_true = value
		update_configuration_warnings()

@export var next_state_false: FSMState:
	set(value):
		next_state_false = value
		update_configuration_warnings()

# Internal flag that determines which state gets transitioned to
var _transition_flag: bool


# Executed when the transition is taken.
func _on_transition(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	pass


# Always returns true, because this transition always triggers one way or another.
# Because `get_next_state()` doesn't have access to the actor or blackboard, a flag is
# set internally here which sets up the next transition.
func is_valid(actor: Node, blackboard: Blackboard) -> bool:
	set_transition_flag(actor, blackboard)
	return true


func set_transition_flag(_actor: Node, _blackboard: Blackboard) -> void:
	pass


## Returns which state to transition to, based on internal transition flag set in `set_transition_flag()`.
func get_next_state() -> FSMState:
	return next_state_true if _transition_flag else next_state_false


# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	var parent: Node = get_parent()
	if not parent is FSMState:
		warnings.append("FSMSplitTransition should be a child of FSMState.")

	if next_state:
		warnings.append("FSMSplitTransition has next state; unset and set true and false states.")

	if not next_state_true:
		warnings.append("FSMSplitTransition has no next state for true.")

	if not next_state_false:
		warnings.append("FSMSplitTransition has no next state for false.")

	if use_event and event == "":
		warnings.append("FSMSplitTransition has no event set.")

	return warnings
