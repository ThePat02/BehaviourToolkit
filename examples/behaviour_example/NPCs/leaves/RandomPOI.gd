extends BTLeaf

var last_target_position = Vector2.ZERO


func tick(actor: Node, blackboard: Blackboard) -> Status:
	if (
		actor.navigation_agent.is_navigation_finished()
		and actor.navigation_agent.target_position != last_target_position
	):
		last_target_position = actor.navigation_agent.target_position
		return Status.SUCCESS

	if actor.navigation_agent.target_position != last_target_position:
		return Status.RUNNING

	# Get random location
	var locations = blackboard.get_value("locations")
	randomize()
	var location = locations[randi() % locations.size()]

	actor.move_to(location.position)
	return Status.RUNNING
