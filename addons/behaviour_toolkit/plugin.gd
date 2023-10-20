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
const icon_gear = preload("res://addons/behaviour_toolkit/icons/Gear.svg")
const icon_behaviour_toolkit = preload("res://addons/behaviour_toolkit/icons/MainIcon.svg")
const icon_finite_state_machine = preload("res://addons/behaviour_toolkit/icons/FiniteStateMachine.svg")
const icon_fsm_state = preload("res://addons/behaviour_toolkit/icons/FSMState.svg")
const icon_fsm_transition = preload("res://addons/behaviour_toolkit/icons/FSMTransition.svg")


func _enter_tree():
	add_custom_type("BehaviourToolkit", "Node", behaviour_toolkit, icon_behaviour_toolkit)
	add_custom_type("Blackboard", "Node", blackboard, icon_placeholder)

	add_custom_type("FiniteStateMachine", "Node", finite_state_machine, icon_finite_state_machine)
	add_custom_type("FSMState", "Node", fsm_state, icon_fsm_state)
	add_custom_type("FSMTransition", "Node", fsm_transition, icon_fsm_transition)


func _exit_tree():
	remove_custom_type("BehaviourToolkit")
	remove_custom_type("Blackboard")

	remove_custom_type("FiniteStateMachine")
	remove_custom_type("FSMState")
	remove_custom_type("FSMTransition")
