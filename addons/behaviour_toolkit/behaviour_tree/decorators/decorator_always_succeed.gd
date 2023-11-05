@icon("res://addons/behaviour_toolkit/icons/BTDecoratorSucceed.svg")
class_name BTAlwaysSucceed extends BTDecorator
## The leaf will always succeed after running.


func tick(actor: Node, blackboard: Blackboard):
	var response = leaf.tick(actor, blackboard)

	if response == Status.RUNNING:
		return Status.RUNNING

	return Status.SUCCESS
