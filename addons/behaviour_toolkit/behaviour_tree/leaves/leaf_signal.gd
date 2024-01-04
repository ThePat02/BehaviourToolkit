@tool
@icon("res://addons/behaviour_toolkit/icons/BTLeafSignal.svg")
class_name LeafSignal extends BTLeaf
## Leaf that emits a signal with optional array of arguments.
## 
## [LeafSignal] if `target_type` is set to `Self` emits it's own signal
## `leaf_emitted(arguments_array)` but can also emit signals from the `actor`,
## or any `Custom` [Node].


## The target type from which to emit signal.
## Can be the actor, a custom node or [LeafSignal] own signal.
enum EmitTarget {
	ACTOR, ## The actor node set on the BTRoot node.
	CUSTOM, ## A custom node set on the custom_target variable.
	SELF, ## Don't emit signals from any target.
}


## Signal emitted on every [code]tick()[/code] by the [LeafSignal]
## if `EmitTarget.SELF` enabled.
signal leaf_emitted(arguments_array: Array)


## The signal name to call on the target node.
@export var signal_name: StringName:
	set(value):
		signal_name = value
		update_configuration_warnings()
## Array of arguments emitted with the [code]leaf_emitted/code] signal.
@export var arguments: Array = []

@export_category("Target")
## The target type to emit signal. Can be the actor, a custom node
## or [LeafSignal] own signal `leaf_emitted` (When target type is `Self`).
@export var target_type: EmitTarget = EmitTarget.SELF:
	set(value):
		target_type = value
		update_configuration_warnings()
## The custom node to call the method on. Only used if target_type
## is set toCallTarget.CUSTOM.
@export var custom_target: Node:
	set(value):
		custom_target = value
		update_configuration_warnings()




func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	var target: Node
	
	match target_type:
		EmitTarget.ACTOR:
			target = _actor
		EmitTarget.CUSTOM:
			target = custom_target
		EmitTarget.SELF:
			emit_signal("leaf_emitted", arguments)
			return BTStatus.SUCCESS
	
	if target.has_signal(signal_name):
		target.emit_signal(signal_name, arguments)
	else:
		print("Signal " + signal_name + " not found on target " + target.to_string())
		return BTStatus.FAILURE

	return BTStatus.SUCCESS


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	if signal_name == "":
		warnings.append("Signal is not set.")
	
	if target_type == EmitTarget.CUSTOM and custom_target == null:
		warnings.append("Target type is set to Custom but no custom target is set.")

	return warnings
