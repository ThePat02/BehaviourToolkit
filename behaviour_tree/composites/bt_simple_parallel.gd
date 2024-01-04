@tool
@icon("res://addons/behaviour_toolkit/icons/BTSimpleParallel.svg")
class_name BTSimpleParallel extends BTComposite
## Executes all children in parallel, and returns SUCCESS depending on the
## policy. It returns FAILURE if any child returns FAILURE.


enum ParallelPolicy {
	SUCCESS_ON_ALL,		## Returns SUCCESS if all children return SUCCESS.
	SUCCESS_ON_ONE,		## Returns SUCCESS if any child returns SUCCESS.
}


## Select when to return SUCCESS.
@export var policy: ParallelPolicy = ParallelPolicy.SUCCESS_ON_ALL
## If true, children that have already returned SUCCESS will not be ticked again, until one of the children returns FAILURE or the composite is reset.
@export var synchronize: bool = false


@onready var responses: Dictionary = {}


func tick(delta: float, actor: Node, blackboard: Blackboard):
	var leave_counter = 0
	for leave in leaves:
		# If the Parrallel is synchronized, skip leaves that have already returned SUCCESS.
		if synchronize and (responses.get(leave_counter) == BTStatus.SUCCESS):
			leave_counter += 1
			continue

		var response = leave.tick(delta, actor, blackboard)
		responses[leave_counter] = response
		leave_counter += 1

		# Abort if any child returns FAILURE.
		if response == BTStatus.FAILURE:
			responses.clear()
			return BTStatus.FAILURE
		
		if policy == ParallelPolicy.SUCCESS_ON_ONE:
			if response == BTStatus.SUCCESS:
				responses.clear()
				return BTStatus.SUCCESS

	if policy == ParallelPolicy.SUCCESS_ON_ALL:
		var index = 0
		for response in responses.values():
			if response != BTStatus.SUCCESS:
				return BTStatus.RUNNING
			
			index += 1
		
		responses.clear()
		return BTStatus.SUCCESS
	
	return BTStatus.RUNNING
