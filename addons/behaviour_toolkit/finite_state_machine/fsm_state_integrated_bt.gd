@icon("res://addons/behaviour_toolkit/icons/FSMStateIntegration.svg")
class_name FSMStateIntegratedBT extends FSMState



@onready var behaviour_tree: BTRoot = _get_behaviour_tree()


@export var fire_event_on_status: bool = false
@export var on_status: BTBehaviour.Status = BTBehaviour.Status.SUCCESS
@export var event: String


## Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	behaviour_tree.active = true


## Executes every process call, if the state is active.
func _on_update(_actor: Node, _blackboard: Blackboard) -> void:
	if behaviour_tree.current_status == on_status:
		if fire_event_on_status:
			get_parent().fire_event(event)


## Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	behaviour_tree.active = false


func _get_behaviour_tree() -> BTRoot:
	if get_child_count() == 0:
		return null
	
	for child in get_children():
		if child is BTRoot:
			return child

	return null
