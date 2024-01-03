@tool
@icon("res://addons/behaviour_toolkit/icons/BTCompositeIntegration.svg")
class_name BTIntegratedFSM extends BTComposite
## A composite behaviour node that allows to integrate [FiniteStateMachine]
## in a behaviour tree by handling FSM node.
##
## To nest a FSM you need to add a [FiniteStateMachine] as a first child of
## [BTIntegratedFSM]. When this behaviour is evaluated the child FSM
## is set to active.
## [br][br]
## After the FSM is started it returns status
## [enum BTBehaviour.BTStatus.RUNNING]. If FSM return
## [enum BTBehaviour.BTStatus.SUCCESS] or [enum BTBehaviour.BTStatus.FAILURE]
## the child FSM is stopped.


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


func _get_configuration_warnings() -> PackedStringArray:
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
