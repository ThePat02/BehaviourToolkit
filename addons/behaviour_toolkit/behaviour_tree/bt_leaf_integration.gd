@tool
@icon("res://addons/behaviour_toolkit/icons/BTLeafIntegration.svg")
class_name BTLeafIntegration extends BTLeaf
## Base class to build [BTLeaf]s that act on [FiniteStateMachine].


@export var state_machine: FiniteStateMachine:
	set(value):
		state_machine = value
		update_configuration_warnings()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	if state_machine == null:
		warnings.append("No state machine set.")

	return warnings
