@tool
@icon("res://addons/behaviour_toolkit/icons/BTLeafCall.svg")
class_name LeafCall extends BTLeaf
## Leaf that calls a method on a target node.
##
## The target can be the actor, the blackboard or a custom node.
## Returns FAILURE if the method is not found on the target node.


## The target type of the call. Can be the actor, the blackboard or a custom node.
enum CallTarget {
	ACTOR,          ## The actor node set on the BTRoot node.
	BLACKBOARD,     ## The blackboard node set on the BTRoot node.
	CUSTOM,         ## A custom node set on the custom_target variable.
}


## The method to call on the target node.
@export var method: StringName:
	set(value):
		method = value
		update_configuration_warnings()
## The arguments to pass to the method.
@export var arguments: Array = []

@export_category("Target")
## The target type of the call. Can be the actor, the blackboard or a custom node.
@export var target_type: CallTarget = CallTarget.ACTOR:
	set(value):
		target_type = value
		update_configuration_warnings()
## The custom node to call the method on. Only used if target_type is set to CallTarget.CUSTOM.
@export var custom_target: Node:
	set(value):
		custom_target = value
		update_configuration_warnings()


func tick(delta: float, actor: Node, blackboard: Blackboard):
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
		return BTStatus.FAILURE

	return BTStatus.SUCCESS


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	if method == "":
		warnings.append("Method is not set.")
	
	if target_type == CallTarget.CUSTOM and custom_target == null:
		warnings.append("Target type is set to CUSTOM but no custom target is set.")

	return warnings
