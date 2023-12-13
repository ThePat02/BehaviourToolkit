@icon("res://addons/behaviour_toolkit/icons/BTCompositeIntegration.svg")
class_name BTIntegratedFSM extends BTComposite


@onready var state_machine: FiniteStateMachine = _get_machine()


func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	if state_machine.active == false:
		state_machine.start()

	if not state_machine.current_bt_status == BTStatus.RUNNING:
		state_machine.active = false
	
	return state_machine.current_bt_status


func _get_machine() -> FiniteStateMachine:
	if get_child_count() == 0:
		return null
	else:
		return get_child(0)
