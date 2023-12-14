extends BTLeaf


func tick(actor: Node, _blackboard: Blackboard) -> Status:
	if actor.thirst == 0:
		return Status.FAILURE

	return Status.SUCCESS
