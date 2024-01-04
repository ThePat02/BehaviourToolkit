@tool
@icon("res://addons/behaviour_toolkit/icons/BTLeafCondition.svg")
class_name LeafCondition extends BTLeaf
## Leaf evaluating a condition statement using a property.
##
## The node queries a property of the actor or a custom node and compares it
## to a value. Returns SUCCESS if the condition is met, FAILURE otherwise.
## Also returns FAILURE if the property does not exist.


enum ConditionTarget {
	ACTOR,
	CUSTOM,
}


enum ConditionValue {
	STRING,
	INT,
	FLOAT,
	BOOL,
}


enum ConditionType {
	EQUAL,
	NOT_EQUAL,
	GREATER,
	GREATER_EQUAL,
	LESS,
	LESS_EQUAL,
	CUSTOM_SCRIPT,
}


## The default custom script template.
const DEFAULT_CUSTOM_SCRIPT = "# Custom Condition\nstatic func is_valid(_actor: Node, _blackboard: Blackboard) -> bool:\n\t# Compute your custom logic here\n\treturn true\n"


## The property of the target node to query.
@export var condition_property: StringName:
	set(value):
		condition_property = value
		update_configuration_warnings()
## The type of comparison to perform.
@export var condition_type: ConditionType = ConditionType.EQUAL:
	set(value):
		condition_type = value
		notify_property_list_changed()
## The custom script to use for the comparison. Only used if condition_type is set to CUSTOM_SCRIPT.
@export var custom_script: Script:
	set(value):
		if value == null:
			custom_script = null
			return

		if not value.has_source_code():
			value.source_code = DEFAULT_CUSTOM_SCRIPT

		custom_script = value
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
@export var target_type: ConditionTarget = ConditionTarget.ACTOR:
	set(value):
		target_type = value
		update_configuration_warnings()
## The custom node to query. Only used if target_type is set to CUSTOM.
@export var custom_target: Node:
	set(value):
		custom_target = value
		update_configuration_warnings()


func tick(delta: float, actor: Node, _blackboard: Blackboard):
	var target: Node
	match target_type:
		ConditionTarget.ACTOR:
			target = actor
		ConditionTarget.CUSTOM:
			target = custom_target
	
	# If it is a custom script condition, call it
	if condition_type == ConditionType.CUSTOM_SCRIPT:
		var result: bool = custom_script.is_valid(target, _blackboard)

		if not result:
			return BTStatus.FAILURE
		else:
			return BTStatus.SUCCESS
	
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
		return BTStatus.FAILURE
	
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
		return BTStatus.FAILURE
	else:
		return BTStatus.SUCCESS


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	if condition_property == "" and condition_type != ConditionType.CUSTOM_SCRIPT:
		warnings.append("Condition property is empty.")
	
	if condition_type == ConditionType.CUSTOM_SCRIPT and custom_script == null:
		warnings.append("Custom script is not assigned.")
	
	if target_type == ConditionTarget.CUSTOM and custom_target == null:
		warnings.append("Custom target is not assigned.")

	return warnings
