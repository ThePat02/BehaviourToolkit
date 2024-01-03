@icon("res://addons/behaviour_toolkit/icons/FSMStateIntegrationReturn.svg")
class_name FSMStateIntegrationReturn extends FSMState
## A state in a [FiniteStateMachine] that allows to exit State Machine nested
## inside of a Behaviour Tree.
##
## The state when active returns [enum BTStatus.SUCCESS] or
## [enum BTStatus.FAILURE] depending on the state's return_status property,
## which stops execution of FSM attached to [BTIntegratedFSM].

enum BTStatus {
	SUCCESS,
	FAILURE,
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


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	var fsm_parent: Node = get_parent().get_parent()

	if not fsm_parent is BTIntegratedFSM:
		warnings.append("Can only return from a BTIntegratedFSM.")

	return warnings
