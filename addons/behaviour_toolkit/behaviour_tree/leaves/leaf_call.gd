@icon("res://addons/behaviour_toolkit/icons/BTLeafCall.svg")
class_name LeafCall extends BTLeaf
## Leaf that calls a method on a target node. The target can be the actor, the blackboard or a custom node.
## Returns FAILURE if the method is not found on the target node.


## The target type of the call. Can be the actor, the blackboard or a custom node.
enum CallTarget {
    ACTOR,          ## The actor node set on the BTRoot node.
    BLACKBOARD,     ## The blackboard node set on the BTRoot node.
    CUSTOM          ## A custom node set on the custom_target variable.
}


## The method to call on the target node.
@export var method: String
## The arguments to pass to the method.
@export var arguments: Array = []

@export_category("Target")
## The target type of the call. Can be the actor, the blackboard or a custom node.
@export var target_type: CallTarget = CallTarget.ACTOR
## The custom node to call the method on. Only used if target_type is set to CallTarget.CUSTOM.
@export var custom_target: Node


func tick(actor: Node, blackboard: Blackboard):
    var target

    match target_type:
        CallTarget.ACTOR:
            target = actor
        CallTarget.BLACKBOARD:
            target = blackboard
        CallTarget.CUSTOM:
            target = custom_target
    
    if target.has_method(method):
        target.callv(method, arguments)
    else:
        print("Method " + method + " not found on target " + target.to_string())
        return Status.FAILURE

    return Status.SUCCESS
