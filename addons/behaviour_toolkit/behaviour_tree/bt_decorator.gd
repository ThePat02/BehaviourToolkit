@icon("res://addons/behaviour_toolkit/icons/BTDecorator.svg")
class_name BTDecorator extends BTBehaviour


## The leaf the decorator is decorating.
@onready var leaf: BTBehaviour =  _get_leaf()


func _get_leaf() -> BTBehaviour:
    if get_child_count() == 0:
        return null
    
    return get_child(0)
