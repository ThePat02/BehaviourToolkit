@icon("res://addons/behaviour_toolkit/icons/BTDecoratorLimiter.svg")
class_name BTLimiter extends BTDecorator
## Limits the number of times a leaf can be run. (The leaf will fully run, before triggering the limit.)


@export var limit: int = 1
@export var on_limit: Status = Status.FAILURE


@onready var cache_key = 'limiter_%s' % self.get_instance_id()


func tick(actor: Node, blackboard: Blackboard):
	var current_count = blackboard.get_value(cache_key)
	if current_count == null:
		current_count = 0
	
	if current_count < limit:
		var response = leaf.tick(actor, blackboard)
		if response == Status.RUNNING:
			return response

		blackboard.set_value(cache_key, current_count + 1)
		return response
	else:
		return on_limit


func reset(actor: Node, blackboard: Blackboard):
	blackboard.set_value(cache_key, 0)
