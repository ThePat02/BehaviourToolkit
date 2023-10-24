extends BTLeaf


@export var direction: Vector2 = Vector2.ZERO
@export var speed: float = 0.1


func tick(actor: Node, _blackboard: Blackboard) -> Status:
	actor.position += direction * speed
	return Status.SUCCESS

