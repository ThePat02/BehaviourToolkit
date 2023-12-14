extends BTDecorator


# Gets called every tick of the behavior tree
# `leaf` is the child of this decorator and is automatically set @onready
func tick(actor: Node, blackboard: Blackboard) -> Status:
    var response = leaf.tick(actor, blackboard)

    # Augment the response of the leaf

    return response
