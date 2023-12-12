@tool
extends BTDecorator


# Gets called every tick of the behavior tree
# `leaf` is the child of this decorator and is automatically set @onready
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	var response = leaf.tick(_delta, _actor, _blackboard)

	# Augment the response of the leaf

	return response
