@tool
@icon("res://addons/behaviour_toolkit/icons/BTDecoratorFail.svg")
class_name BTAlwaysFail extends BTDecorator
## The leaf will always fail after running.


func tick(delta: float, actor: Node, blackboard: Blackboard):
	var response = leaf.tick(delta, actor, blackboard)

	if response ==  BTStatus.RUNNING:
		return BTStatus.RUNNING

	return BTStatus.FAILURE
