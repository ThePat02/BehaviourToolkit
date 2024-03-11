@tool
extends BTLeaf


# Gets called every tick of the behavior tree
func tick(delta: float, actor, blackboard: Blackboard) -> BTStatus:
	actor = actor as CharacterBody2D
	var target: Vector2 = blackboard.get_value("target")

	var diff: Vector2 = target - actor.global_position
	if diff.length() < 5:
		print("target reached")
		actor.velocity = Vector2.ZERO
		return BTStatus.SUCCESS
	else:
		actor.velocity = diff.normalized() * 128.0
		actor.move_and_slide()
		return BTStatus.RUNNING
