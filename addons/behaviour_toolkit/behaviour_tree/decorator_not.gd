class_name NotDecorator extends BTDecorator


@onready var leaf: BTBehaviour = get_child(0)


func tick(actor: Node, blackboard: Blackboard):
    var response = leaf.tick(actor, blackboard)

    if response == Status.SUCCESS:
        return Status.FAILURE
    
    if response == Status.FAILURE:
        return Status.SUCCESS

    return Status.RUNNING
