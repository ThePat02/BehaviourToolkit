@tool
extends BTDecorator


# Gets called every tick of the behavior tree
# `leaf` is the child of this decorator and is automatically set @onready
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	var response = leaf.tick(_delta, _actor, _blackboard)

	# Augment the response of the leaf

	return response


# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	# Add your own warnings to the array here

	return warnings
