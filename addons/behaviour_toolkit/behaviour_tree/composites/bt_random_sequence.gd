@icon("res://addons/behaviour_toolkit/icons/BTCompositeRandomSequence.svg")
class_name BTRandomSequence extends BTComposite
## The squence composite but with a random order of the leaves.


var is_shuffled: bool = false
var current_leaf: int = 0


func tick(actor: Node, blackboard: Blackboard):
	if not is_shuffled:
		leaves.shuffle()

	if current_leaf > leaves.size() -1:
		current_leaf = 0
		is_shuffled = false
		return Status.SUCCESS

	var response = leaves[current_leaf].tick(actor, blackboard)

	if response == Status.RUNNING:
		return response
	
	if response == Status.FAILURE:
		current_leaf = 0
		is_shuffled = false
		return response
	
	current_leaf += 1
	return Status.RUNNING
