extends BTLeaf


@export var animation: String


func tick(actor: Node, _blackboard: Blackboard) -> Status:
	actor.animation_player.play(animation)
	return Status.SUCCESS

