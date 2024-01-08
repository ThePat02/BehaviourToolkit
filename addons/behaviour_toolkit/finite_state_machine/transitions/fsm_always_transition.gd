@tool
@icon("res://addons/behaviour_toolkit/icons/FSMAlwaysTransition.svg")
class_name FSMAlwaysTransition extends FSMTransition
## A transition between two [FSMState]s in a [FiniteStateMachine].
##
## This is a convenience class that always transitions. To implement your
## logic you can override the [code]_on_transition[/code] method when
## extending the node's script.[br]


# Evaluates true, if the transition conditions are met.
func is_valid(_actor: Node, _blackboard: Blackboard) -> bool:
	return true


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	if use_event or event != "":
		warnings.append("FSMAlwaysTransition does not use events.")

	return warnings
