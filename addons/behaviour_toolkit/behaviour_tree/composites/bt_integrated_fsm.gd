@tool
@icon("res://addons/behaviour_toolkit/icons/BTCompositeIntegration.svg")
class_name BTIntegratedFSM extends BTComposite


var state_machine: FiniteStateMachine = null

func _ready():
	if not Engine.is_editor_hint():
		state_machine = _get_machine()
		

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


func _get_configuration_warnings():
	var warnings: Array = []
	var children = get_children()

	if children.size() == 0:
		warnings.append("BTIntegratedFSM must have a child node. The first child will be used as the state machine.")

	if children.size() > 1:
		warnings.append("BTIntegratedFSM can only have one child node. The first child will be used as the state machine.")
	
	if children.size() == 1:
		if not children[0] is FiniteStateMachine:
			warnings.append("BTIntegratedFSM's child node must be a FiniteStateMachine. The first child will be used as the state machine.")

	return warnings
