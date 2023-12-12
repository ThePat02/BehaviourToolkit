@tool
extends BTComposite


# Gets called every tick of the behavior tree
# `leaves` is an array of the children of this node set @onready
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	# Logic for ticking one or more leaves
	# Return BTStatus depending on the result of the leaves
	# Return BTStatus.RUNNING, if there are still leaves to tick
	return BTStatus.SUCCESS
