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
## After that, the final status of the FSM will be returned
## as the final status of the [BTIntegratedFSM] node.
## [br][br]
## When [BTIntegratedFSM] finds node of type [FiniteStateMachine] as it's first
## child it starts the state machine and runs it on every
## [code]tick()[/code] until the FSM node itself will stop returning
## [enum BTBehaviour.BTStatus.RUNNING].
## [br][br]
## In case where [BTComposite] can't find [FiniteStateMachine] as it's first
## child [enum BTBehaviour.BTStatus.FAILURE] will be returned.


## Default status in case [BTIntegratedFSM] will not find [FiniteStateMachine]
## child as a first node.
@export_enum("SUCCESS", "FAILURE") var default_status: String = "FAILURE":
	set(value):
		if value == "SUCCESS":
			_default_status = BTStatus.SUCCESS
		else:
			_default_status = BTStatus.FAILURE


var _default_status: BTStatus = BTStatus.FAILURE


# Connecting signal using @onready to omit the need to use super() call
# in _ready() of extended nodes if they override _ready().
@onready var __connect_finite_state_machine_changed: int = \
	child_order_changed.connect(_finite_state_machine_changed)

@onready var state_machine: FiniteStateMachine = _get_machine()


func _ready():
	if not Engine.is_editor_hint():
		state_machine = _get_machine()
		


func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	if state_machine == null:
		return _default_status
	
	if state_machine.active == false:
		state_machine.start()

	if not state_machine.current_bt_status == BTStatus.RUNNING:
		state_machine.active = false
	
	return state_machine.current_bt_status


## Swap this composite nodes current state machine with the provided one.
## If state has no [FiniteStateMachine] as a child the provided one will be added.
## [br][br]
## Old state machine is freed and the new machine will be started on the next
## [code]tick()[/code] callback call.
func swap_finite_state_machine(finite_state_machine: FiniteStateMachine, 
	force_readable_name: bool = false, keep_groups: bool = false) -> void:
	
	if keep_groups == true and state_machine != null:
		for g in state_machine.get_groups():
			if not finite_state_machine.is_in_group(g):
				finite_state_machine.add_to_group(g, true)
	
	if state_machine == null:
		add_child(finite_state_machine, force_readable_name)
	else:
		state_machine.queue_free()
		add_child(finite_state_machine, force_readable_name)


func _get_machine() -> FiniteStateMachine:
	if get_child_count() == 0:
		return null
	else:
		if get_child(0) is FiniteStateMachine:
			return get_child(0)
	
	return null


func _finite_state_machine_changed() -> void:
	if Engine.is_editor_hint():
		return
	
	state_machine = _get_machine()
	state_machine.autostart = false


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	var children = get_children()

	if children.size() == 0:
		warnings.append("BTIntegratedFSM should have a child node to work. The first child will be used as the state machine.")

	if children.size() > 1:
		warnings.append("BTIntegratedFSM has more than one child node. Only the first child will be used as the state machine.")
	
	if children.size() == 1:
		if not children[0] is FiniteStateMachine:
			warnings.append("BTIntegratedFSM's first child node must be a FiniteStateMachine. The first child will be used as the state machine.")

	return warnings
