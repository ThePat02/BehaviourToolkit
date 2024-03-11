@tool
extends ScrollContainer

@onready var fsm_table_control = $FSMTableControl


func set_finite_state_machine(fsm: FiniteStateMachine) -> void:
	fsm_table_control.set_finite_state_machine(fsm)
