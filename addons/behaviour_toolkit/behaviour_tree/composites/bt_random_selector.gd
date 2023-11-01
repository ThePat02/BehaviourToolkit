@icon("res://addons/behaviour_toolkit/icons/BTCompositeRandomSelector.svg")
class_name BTRandomSelector extends BTComposite
## The selector composite but with a random order of the leaves.


var is_shuffled: bool = false
var current_leaf: int = 0


func tick(actor: Node, blackboard: Blackboard):
	if not is_shuffled:
		leaves.shuffle()

	if current_leaf > leaves.size() -1:
		current_leaf = 0
		is_shuffled = false
		return Status.FAILURE
	
	var response = leaves[current_leaf].tick(actor, blackboard)

	if response == Status.SUCCESS:
		current_leaf = 0
		is_shuffled = false
		return response
	
	if response == Status.RUNNING:
		return response
	
	current_leaf += 1
	return Status.RUNNING
