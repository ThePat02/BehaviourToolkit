@tool
extends FSMTransition

# Evaluates true, if the transition conditions are met.
func is_valid(_actor: Node, _blackboard: Blackboard) -> bool:
	return _blackboard.get_value("counter") == 10
