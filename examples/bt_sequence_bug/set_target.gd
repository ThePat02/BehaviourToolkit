@tool
extends BTLeaf


func tick(_delta, _actor, blackboard: Blackboard) -> BTStatus:
	var target: Vector2 = owner.get_global_mouse_position()
	print("Setting target: ", target)
	blackboard.set_value("target", target)
	return BTStatus.SUCCESS
