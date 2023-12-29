@tool
@icon("res://addons/behaviour_toolkit/icons/BTDecorator.svg")
class_name BTDecorator extends BTBehaviour
## Base class for decorators.
##
## Decorators are used to augment the behaviour of a leaf.[br]
## Think of it as another layer of logic that is executed before the leaf.


## The leaf the decorator is decorating.
@onready var leaf: BTBehaviour =  _get_leaf()


func _get_leaf() -> BTBehaviour:
	if get_child_count() == 0:
		return null
	
	return get_child(0)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	
	var parent = get_parent()
	var children = get_children()

	if not parent is BTComposite and not parent is BTRoot:
		warnings.append("Decorator node should be a child of a composite node or the root node.")
	
	if children.size() == 0:
		warnings.append("Decorator node should have a child.")
	elif children.size() > 1:
		warnings.append("Decorator node should have only one child.")
	elif not children[0] is BTBehaviour:
		warnings.append("Decorator node should have a BTBehaviour node as a child.")

	return warnings
