extends FSMTransition

## Executed when the transition is taken.
func _on_transition() -> void:
	pass


## Evaluates true, if the transition conditions are met.
func is_valid() -> bool:
	return false
