@tool
extends FSMAlwaysTransition


# Executed when the transition is taken.
func _on_transition(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	pass


# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	# Add your own warnings to the array here

	return warnings
