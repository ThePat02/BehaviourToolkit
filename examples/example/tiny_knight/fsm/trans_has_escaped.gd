extends FSMTransition


@export var actor: Node


## Executed when the transition is taken.
func _on_transition():
	pass


## Evaluates true, if the transition conditions are met.
func is_valid():
	var ghosts = get_tree().get_nodes_in_group("ghost")
	for ghost in ghosts:
		if ghost.position.distance_to(actor.position) < 300:
			return false
	return true

