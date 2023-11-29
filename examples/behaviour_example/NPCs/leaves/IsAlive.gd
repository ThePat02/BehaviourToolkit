extends BTLeaf


func tick(delta: float, actor: Node, _blackboard: Blackboard) -> BTStatus:
	if actor.alive:
		return BTStatus.SUCCESS
	
	return BTStatus.FAILURE

