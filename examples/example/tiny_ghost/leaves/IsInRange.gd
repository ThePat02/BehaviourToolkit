extends BTLeaf


@export var target_name: String


func tick(_actor: Node, blackboard: Blackboard) -> Status:
	var overlapping_bodies = blackboard.get_value("overlapping_bodies")

	for body in overlapping_bodies:
		if body.name == target_name:
			blackboard.set_value("target", body)
			body.fsm.fire_event("is_hunted")
			return Status.SUCCESS
	return Status.FAILURE
