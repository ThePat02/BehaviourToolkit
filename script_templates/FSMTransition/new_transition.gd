extends FSMTransition

# Executed when the transition is taken.
func _on_transition(_actor: Node, _blackboard: Blackboard) -> void:
	pass


# Evaluates true, if the transition conditions are met.
func is_valid(_actor: Node, _blackboard: Blackboard) -> bool:
	return false
