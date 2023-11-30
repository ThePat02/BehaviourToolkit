extends BTLeaf


var last_target_position = Vector2.ZERO


func tick(_delta: float, actor: Node, blackboard: Blackboard) -> BTStatus:
	if actor.navigation_agent.is_navigation_finished() and actor.navigation_agent.target_position != last_target_position:
		last_target_position = actor.navigation_agent.target_position
		return BTStatus.SUCCESS
	
	if actor.thirst > 0:
		actor.state_machine.fire_event("start_refreshing")
		return BTStatus.SUCCESS
	
	if actor.navigation_agent.target_position != last_target_position:
		return BTStatus.RUNNING

	# Get random location
	var well = blackboard.get_value("well_area")
	actor.move_to(well.position)
	return BTStatus.RUNNING

