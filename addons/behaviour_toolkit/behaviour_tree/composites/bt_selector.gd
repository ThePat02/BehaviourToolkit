@icon("res://addons/behaviour_toolkit/icons/BTCompositeSelector.svg")
class_name BTSelector extends BTComposite
## Selects the first child that succeeds, or fails if none do.


var current_leaf: int = 0


func tick(actor: Node, blackboard: Blackboard):
	if current_leaf > leaves.size() -1:
		current_leaf = 0
		return Status.FAILURE
	
	var response = leaves[current_leaf].tick(actor, blackboard)

	if response == Status.SUCCESS:
		current_leaf = 0
		return response
	
	if response == Status.RUNNING:
		return response
	
	current_leaf += 1
	return Status.RUNNING
