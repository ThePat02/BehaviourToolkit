@tool
extends BTComposite


# Gets called every tick of the behavior tree
# `leaves` is an array of the children of this node set @onready
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	# Logic for ticking one or more leaves
	# Return BTStatus depending on the result of the leaves
	# Return BTStatus.RUNNING, if there are still leaves to tick
	return BTStatus.SUCCESS


# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	# Add your own warnings to the array here

	return warnings
