extends BTLeaf


@export var bottle_volume: int = 10


func tick(actor: Node, _blackboard: Blackboard) -> BTStatus:
	actor.state_machine.fire_event("start_refreshing")
	actor.thirst += bottle_volume
	return BTStatus.SUCCESS
