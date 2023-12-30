extends BTLeaf


func tick(_delta: float, actor: Node, _blackboard: Blackboard) -> BTStatus:
	if actor.alive:
		return BTStatus.SUCCESS
	
	return BTStatus.FAILURE

