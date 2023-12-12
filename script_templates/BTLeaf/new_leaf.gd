@tool
extends BTLeaf


# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	# Handle leaf logic
	# Return SUCCESS, FAILURE, or RUNNING
	return BTStatus.SUCCESS
