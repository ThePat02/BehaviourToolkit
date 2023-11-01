@icon("res://addons/behaviour_toolkit/icons/BTDecoratorNot.svg")
class_name NotBT extends BTDecorator


func tick(actor: Node, blackboard: Blackboard):
    var response = leaf.tick(actor, blackboard)

    if response == Status.SUCCESS:
        return Status.FAILURE
    
    if response == Status.FAILURE:
        return Status.SUCCESS

    return Status.RUNNING
