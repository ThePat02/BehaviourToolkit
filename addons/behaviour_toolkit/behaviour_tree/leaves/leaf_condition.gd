@tool
@icon("res://addons/behaviour_toolkit/icons/BTLeafCondition.svg")
class_name LeafCondition extends BTLeaf
## Leaf that queries a property of the actor or a custom node and compares it to a value. Returns SUCCESS if the condition is met, FAILURE otherwise.
## Also returns FAILURE if the property does not exist.


enum ConditionTarget {
    ACTOR,
    CUSTOM
}


enum ConditionValue {
    STRING,
    INT,
    FLOAT,
    BOOL
}


enum ConditionType {
    EQUAL,
    NOT_EQUAL,
    GREATER,
    GREATER_EQUAL,
    LESS,
    LESS_EQUAL
}


## The property of the target node to query.
@export var condition_property: String
## The type of comparison to perform.
@export var condition_type: ConditionType = ConditionType.EQUAL
## The type of the value to compare to.
@export var value_type: ConditionValue = ConditionValue.STRING:
    set(value):
        value_type = value
        notify_property_list_changed()
## The string value to compare to.
@export var condition_value_string: String
## The int value to compare to.
@export var condition_value_int: int
## The float value to compare to.
@export var condition_value_float: float
## The bool value to compare to.
@export var condition_value_bool: bool

@export_category("Target")
## The target node to query. If set to ACTOR, the actor will be queried.
@export var target_type: ConditionTarget = ConditionTarget.ACTOR
## The custom node to query. Only used if target_type is set to CUSTOM.
@export var custom_target: Node


func tick(actor: Node, _blackboard: Blackboard):
    var target: Node
    match target_type:
        ConditionTarget.ACTOR:
            target = actor
        ConditionTarget.CUSTOM:
            target = custom_target
    
    var value: Variant
    match value_type:
        ConditionValue.STRING:
            value = condition_value_string
        ConditionValue.INT:
            value = condition_value_int
        ConditionValue.FLOAT:
            value = condition_value_float
        ConditionValue.BOOL:
            value = condition_value_bool

    var property_value = target.get(condition_property)

    if property_value == null:
        return Status.FAILURE
    
    var result: bool
    match condition_type:
        ConditionType.EQUAL:
            result = property_value == value
        ConditionType.NOT_EQUAL:
            result = property_value != value
        ConditionType.GREATER:
            result = property_value > value
        ConditionType.GREATER_EQUAL:
            result = property_value >= value
        ConditionType.LESS:
            result = property_value < value
        ConditionType.LESS_EQUAL:
            result = property_value <= value
    
    if not result:
        return Status.FAILURE

    return Status.SUCCESS
