@tool
@icon("res://addons/behaviour_toolkit/icons/BTCompositeSelector.svg")
class_name BTSelector extends BTComposite
## Selects the first child that succeeds, or fails if none do.


var current_leaf: int = 0


func tick(delta: float, actor: Node, blackboard: Blackboard):
	if current_leaf > leaves.size() -1:
		current_leaf = 0
		return BTStatus.FAILURE
	
	var response = leaves[current_leaf].tick(delta, actor, blackboard)

	if response == BTStatus.SUCCESS:
		current_leaf = 0
		return response
	
	if response == BTStatus.RUNNING:
		return response
	
	current_leaf += 1
	return BTStatus.RUNNING
