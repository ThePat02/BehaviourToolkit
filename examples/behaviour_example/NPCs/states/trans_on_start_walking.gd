extends FSMTransition

## Executed when the transition is taken.
func _on_transition(_delta: float, _actor: Node, _blackboard: Blackboard):
	pass


## Evaluates true, if the transition conditions are met.
func is_valid(_actor: Node, _blackboard: Blackboard):
	return false

