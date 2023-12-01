@tool
@icon("res://addons/behaviour_toolkit/icons/FSMState.svg")
class_name FSMState extends BehaviourToolkit
## A state in a [FiniteStateMachine]. This is the base class for all states.
##
## It's a basic building block to build full State Machines, only one state
## held by [FiniteStateMachine] is active, to switch to a different state,
## a [FSMTransition] must be triggered or you can use FSM methods to switch
## states manually.
## To implement your logic you can override the [code]_on_enter, _on_update and
## _on_exit[/code] methods when extending the node's script.


## List of transitions from this state.
var transitions: Array[FSMTransition] = []


# Connecting signal using @onready to omit the need to use super() call
# in _ready() of extended nodes if they override _ready().
@onready var __connect_update_transitions: int = \
	child_order_changed.connect(_update_transitions)
@onready var __connect_update_transition_on_ready: int = \
	ready.connect(_update_transitions)


## Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	pass


## Executes every process call, if the state is active.
func _on_update(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	pass


## Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	pass


func _update_transitions() -> void:
	# Don't run in editor
	if Engine.is_editor_hint():
		return
		
	transitions.clear()
	for transition in get_children():
		if transition is FSMTransition:
			transitions.append(transition)


func _get_configuration_warnings():
	var warnings = []

	var parent: Node = get_parent()
	if not parent is FiniteStateMachine:
		warnings.append("FSMState must be a child of a FiniteStateMachine node.")

	return warnings
