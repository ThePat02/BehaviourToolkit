@tool
@icon("res://addons/behaviour_toolkit/icons/BTDecorator.svg")
class_name BTDecorator extends BTBehaviour
## Base class for decorators.
##
## Decorators are used to augment the behaviour of a leaf.[br]
## Think of it as another layer of logic that is executed before the leaf.
## [br][br]
## By itself is not doing much but is aware of it's children and holds reference
## to its first child (index 0 child). You can use it to implement custom
## decorators.


# Connecting signal using @onready to omit the need to use super() call
# in _ready() of extended nodes if they override _ready().
@onready var __connect_child_order_changed: int = \
	child_order_changed.connect(_on_child_order_changed)

## The leaf the decorator is decorating.
@onready var leaf: BTBehaviour = _get_leaf()


func _get_leaf() -> BTBehaviour:
	if get_child_count() == 0:
		return null
	
	return get_child(0)


func _on_child_order_changed() -> void:
	if Engine.is_editor_hint():
		return
		
	leaf = _get_leaf()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	
	var parent = get_parent()
	var children = get_children()

	if not parent is BTComposite and not parent is BTRoot:
		warnings.append("Decorator node should be a child of a composite node or the root node.")
	
	if children.size() == 0:
		warnings.append("Decorator node should have a child.")
	elif children.size() > 1:
		warnings.append("Decorator node has more than one child. Only the first child will be used, other sibilings will be ingored.")
	elif not children[0] is BTBehaviour:
		warnings.append("Decorator nodes first child must be a BTBehaviour node.")

	return warnings
