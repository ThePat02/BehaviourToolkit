@icon("res://addons/behaviour_toolkit/icons/BTCompositeSequence.svg")
class_name BTSequence extends BTComposite
## A sequence node will return success if all of its children return success.


var current_leaf: int = 0


func tick(actor: Node, blackboard: Blackboard):
	if current_leaf > leaves.size() -1:
		current_leaf = 0
		return Status.SUCCESS

	var response = leaves[current_leaf].tick(actor, blackboard)

	if response == Status.RUNNING:
		return response
	
	if response == Status.FAILURE:
		current_leaf = 0
		return response
	
	
	current_leaf += 1
	return Status.RUNNING
