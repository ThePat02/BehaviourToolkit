@icon("res://addons/behaviour_toolkit/icons/BTDecoratorFail.svg")
class_name AlwaysFailBT extends BTDecorator


func tick(actor: Node, blackboard: Blackboard):
    var response = leaf.tick(actor, blackboard)

    if response ==  Status.RUNNING:
        return Status.RUNNING

    return Status.FAILURE
