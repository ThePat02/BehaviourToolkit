extends BTLeaf


func tick(_delta: float, actor: Node, _blackboard: Blackboard) -> BTStatus:
	if actor.thirst == 0:
		return BTStatus.FAILURE
	
	return BTStatus.SUCCESS
