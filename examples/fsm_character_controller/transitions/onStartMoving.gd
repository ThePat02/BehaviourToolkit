extends FSMTransition

# Executed when the transition is taken.
func _on_transition(_delta, _actor, _blackboard: Blackboard):
	pass


# Evaluates true, if the transition conditions are met.
func is_valid(actor, _blackboard: Blackboard):
	# Cast actor
	actor = actor as CharacterBody2D
	
	if actor.movement_direction != Vector2.ZERO:
		return true
	return false
