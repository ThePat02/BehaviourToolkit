@tool
@icon("res://addons/behaviour_toolkit/icons/BTLeaf.svg")
class_name BTLeaf extends BTBehaviour
## Basic Leaf node used as a base to model and write custom behaviours for
## [BTRoot]


func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	return BTStatus.SUCCESS


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	
	var parent = get_parent()
	var children = get_children()

	if not parent is BTBehaviour and not parent is BTRoot:
		warnings.append("BTLeaf node must be a child of BTBehaviour or BTRoot node.")

	return warnings
