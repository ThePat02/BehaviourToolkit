@icon("res://addons/behaviour_toolkit/icons/BTComposite.svg")
class_name BTComposite extends BTBehaviour
## Basic Composite node for Behaviour Tree.
##
## By itself is not doing much but is aware of it's children. You can use it
## to implement custom composite behaviours. If you Implement custom composite
## node remember to call [code]super()[/code] first in your custom node
## [code]_ready()[/code] callback!


## The leaves under the composite node.
@onready var leaves: Array = get_children()


func _ready() -> void:
	connect("child_order_changed", _on_child_order_changed)


## BTComposite updates [member BTComposite.leaves] when it's children nodes are
## added, moved or deleted. If you implement custom composite node remember to
## call [code]super()[/code] first in your custom node [code]_ready()[/code] 
## callback!
func _on_child_order_changed() -> void:
	leaves = get_children()
