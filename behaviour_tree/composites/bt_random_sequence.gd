@tool
@icon("res://addons/behaviour_toolkit/icons/BTCompositeRandomSequence.svg")
class_name BTRandomSequence extends BTComposite
## The squence composite but with a random order of the leaves.


var is_shuffled: bool = false
var current_leaf: int = 0


func tick(delta: float, actor: Node, blackboard: Blackboard):
	if not is_shuffled:
		leaves.shuffle()

	if current_leaf > leaves.size() -1:
		current_leaf = 0
		is_shuffled = false
		return BTStatus.SUCCESS

	var response = leaves[current_leaf].tick(delta, actor, blackboard)

	if response == BTStatus.RUNNING:
		return response
	
	if response == BTStatus.FAILURE:
		current_leaf = 0
		is_shuffled = false
		return response
	
	current_leaf += 1
	return BTStatus.RUNNING
