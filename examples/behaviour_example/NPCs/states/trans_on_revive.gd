extends FSMTransition

## Executed when the transition is taken.
func _on_transition(actor: Node, _blackboard: Blackboard):
	actor.alive = true
	actor.age = 1


## Evaluates true, if the transition conditions are met.
func is_valid(_actor: Node, _blackboard: Blackboard):
	return false
