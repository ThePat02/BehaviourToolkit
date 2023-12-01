@tool
@icon("res://addons/behaviour_toolkit/icons/BTComposite.svg")
class_name BTComposite extends BTBehaviour


## The leaves under the composite node.
@onready var leaves: Array = get_children()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	
	var parent = get_parent()
	var children = get_children()

	if not parent is BTComposite and not parent is BTRoot and not parent is BTDecorator:
		warnings.append("BTLeaf node must be a child of BTComposite, BTDecorator or BTRoot node.")
	
	if children.size() == 0:
		warnings.append("BTComposite node must have at least one child.")

	return warnings
