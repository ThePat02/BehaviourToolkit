@icon("res://addons/behaviour_toolkit/icons/FSMStateIntegrationReturn.svg")
class_name FSMStateIntegrationReturn extends FSMState

enum BTStatus {
	SUCCESS,
	FAILURE
}

@export var return_value: BTStatus = BTStatus.SUCCESS


## Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	get_parent().current_bt_status = return_value


## Executes every process call, if the state is active.
func _on_update(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	pass


## Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	pass
