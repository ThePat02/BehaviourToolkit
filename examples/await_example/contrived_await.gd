@tool
extends BTLeaf


# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	# With [BTRoot.allow_await] set to true, this will cause the tree to suspend
	# execution until this resolves.
	await get_tree().create_timer(1.0).timeout
	return BTStatus.SUCCESS
