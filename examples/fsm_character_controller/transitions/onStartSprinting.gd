extends FSMTransition

# Executed when the transition is taken.
func _on_transition(_delta, _actor, _blackboard: Blackboard):
	pass


# Evaluates true, if the transition conditions are met.
func is_valid(_actor, _blackboard: Blackboard):
	if Input.is_action_pressed("action_sprint"):
		return true
	else:
		return false
