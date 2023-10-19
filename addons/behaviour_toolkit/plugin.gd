@tool
extends EditorPlugin


# Nodes
const behaviour_toolkit = preload("res://addons/behaviour_toolkit/behaviour_toolkit.gd")
const blackboard = preload("res://addons/behaviour_toolkit/blackboard.gd")

const finite_state_machine = preload("res://addons/behaviour_toolkit/finite_state_machine/fsm.gd")
const fsm_state = preload("res://addons/behaviour_toolkit/finite_state_machine/fsm_state.gd")
const fsm_transition = preload("res://addons/behaviour_toolkit/finite_state_machine/fsm_transition.gd")


# Icons
const icon_placeholder = preload("res://addons/behaviour_toolkit/icons/placeholder.svg")


func _enter_tree():
	add_custom_type("BehaviourToolkit", "Node", behaviour_toolkit, icon_placeholder)
	add_custom_type("Blackboard", "Node", blackboard, icon_placeholder)

	add_custom_type("FiniteStateMachine", "BehaviourToolkit", finite_state_machine, icon_placeholder)
	add_custom_type("FSMState", "BehaviourToolkit", fsm_state, icon_placeholder)
	add_custom_type("FSMTransition", "BehaviourToolkit", fsm_transition, icon_placeholder)


func _exit_tree():
	remove_custom_type("BehaviourToolkit")
	remove_custom_type("Blackboard")

	remove_custom_type("FiniteStateMachine")
	remove_custom_type("FSMState")
	remove_custom_type("FSMTransition")
