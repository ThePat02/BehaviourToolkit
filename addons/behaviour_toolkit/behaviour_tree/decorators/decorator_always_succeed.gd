@tool
@icon("res://addons/behaviour_toolkit/icons/BTDecoratorSucceed.svg")
class_name BTAlwaysSucceed extends BTDecorator
## The leaf will always succeed after running.


func tick(delta: float, actor: Node, blackboard: Blackboard):
	var response = leaf.tick(delta, actor, blackboard)

	if response == BTStatus.RUNNING:
		return BTStatus.RUNNING

	return BTStatus.SUCCESS
