@tool
@icon("res://addons/behaviour_toolkit/icons/BTComposite.svg")
class_name BTComposite extends BTBehaviour
## Basic Composite node for Behaviour Tree.
##
## By itself is not doing much but is aware of it's children. You can use it
## to implement custom composite behaviours.


# Connecting signal using @onready to omit the need to use super() call
# in _ready() of extended nodes if they override _ready().
@onready var __connect_child_order_changed: int = \
	child_order_changed.connect(_on_child_order_changed)


## The leaves under the composite node.
@onready var leaves: Array = get_children()


func _on_child_order_changed() -> void:
	if Engine.is_editor_hint():
		return
	
	leaves = get_children()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	
	var parent = get_parent()
	var children = get_children()

	if not parent is BTComposite and not parent is BTRoot and not parent is BTDecorator:
		warnings.append("BTComposite node must be a child of BTComposite or BTRoot node.")
	
	if children.size() == 0:
		warnings.append("BTComposite node should have at least one child to work.")
	
	if children.size() == 1:
		warnings.append("BTComposite node should have more than one child.")

	return warnings
