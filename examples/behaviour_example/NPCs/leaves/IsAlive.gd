extends BTLeaf


func tick(actor: Node, _blackboard: Blackboard) -> Status:
	if actor.alive:
		return Status.SUCCESS

	return Status.FAILURE
