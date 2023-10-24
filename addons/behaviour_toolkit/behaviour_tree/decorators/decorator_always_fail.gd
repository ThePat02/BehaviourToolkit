class_name AlwaysFailBT extends BTDecorator


func tick(actor: Node, blackboard: Blackboard):
    leaf.tick(actor, blackboard)
    return Status.FAILURE
