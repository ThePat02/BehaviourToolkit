extends BTLeaf

@export var speed: float = 1

func tick(actor: Node, blackboard: Blackboard) -> Status:
	var target: Node2D = blackboard.get_value("target")

	actor.position += (target.position - actor.position).normalized() * speed 
	return Status.SUCCESS
