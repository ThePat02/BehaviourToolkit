extends BTLeaf


var last_target_position = Vector2.ZERO


func tick(_delta: float, actor: Node, blackboard: Blackboard) -> BTStatus:
	if actor.navigation_agent.is_navigation_finished() and actor.navigation_agent.target_position != last_target_position:
		last_target_position = actor.navigation_agent.target_position
		return BTStatus.SUCCESS
	
	if actor.navigation_agent.target_position != last_target_position:
		return BTStatus.RUNNING

	# Get random location
	var locations = blackboard.get_value("locations")
	randomize()
	var location = locations[randi() % locations.size()]

	actor.move_to(location.position)
	return BTStatus.RUNNING
