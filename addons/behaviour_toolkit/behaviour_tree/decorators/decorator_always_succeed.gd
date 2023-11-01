@icon("res://addons/behaviour_toolkit/icons/BTDecoratorSucceed.svg")
class_name AlwaysSucceedBT extends BTDecorator


func tick(actor: Node, blackboard: Blackboard):
    var response = leaf.tick(actor, blackboard)

    if response == Status.RUNNING:
        return Status.RUNNING

    return Status.SUCCESS
