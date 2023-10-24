class_name AlwaysSucceedBT extends BTDecorator


func tick(actor: Node, blackboard: Blackboard):
    leaf.tick(actor, blackboard)
    return Status.SUCCESS
