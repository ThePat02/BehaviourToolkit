extends BTComposite


# Gets called every tick of the behavior tree
# `leaves` is an array of the children of this node set @onready
func tick(actor: Node, blackboard: Blackboard) -> Status:
    # Logic for ticking one or more leaves
    # Return Status depending on the result of the leaves
    # Return Status.RUNNING, if there are still leaves to tick
    return Status.SUCCESS
