@tool
@icon("res://addons/behaviour_toolkit/icons/FSMSplitTransition.svg")
extends FSMSplitTransition


# Executed when the transition is taken.
func _on_transition(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	pass


# Set `_transition_flag` to true or false, which will determine which transition is taken.
func set_transition_flag(_actor: Node, _blackboard: Blackboard) -> void:
	var counter: int = _blackboard.get_value("counter")
	if counter % 2 == 0:
		_transition_flag = true
	else:
		_transition_flag = false


# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	if use_event or event != "":
		warnings.append("FSMAlwaysTransition does not use events.")

	return warnings
