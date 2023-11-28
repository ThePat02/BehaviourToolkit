@icon("res://addons/behaviour_toolkit/icons/BTDecoratorFail.svg")
class_name BTAlwaysFail extends BTDecorator
## The leaf will always fail after running.


func tick(actor: Node, blackboard: Blackboard):
    var response = leaf.tick(actor, blackboard)

    if response ==  BTStatus.RUNNING:
        return BTStatus.RUNNING

    return BTStatus.FAILURE
