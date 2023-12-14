@icon("res://addons/behaviour_toolkit/icons/BTLeafSignal.svg")
class_name LeafSignal extends BTLeaf
## Leaf that emits a signal with optional array of arguments.
## 
## [LeafSignal] if `target_type` is set to `Self` emits it's own signal
## `leaf_emitted(arguments_array)` but can also emit signals from the `Actor`,
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
@export var signal_name: StringName
## Array of arguments emitted with the [code]leaf_emitted/code] signal.
@export var arguments: Array = []

@export_category("Target")
## The target type to emit signal. Can be the actor, a custom node
## or [LeafSignal] own signal `leaf_emitted` (When target type is `Self`).
@export var target_type: EmitTarget = EmitTarget.SELF
## The custom node to call the method on. Only used if target_type
## is set toCallTarget.CUSTOM.
@export var custom_target: Node




func tick(_actor: Node, _blackboard: Blackboard) -> Status:
	var target: Node
	
	match target_type:
		EmitTarget.ACTOR:
			target = _actor
		EmitTarget.CUSTOM:
			target = custom_target
		EmitTarget.SELF:
			emit_signal("leaf_emitted", arguments)
			return Status.SUCCESS
	
	if target.has_signal(signal_name):
		target.emit_signal(signal_name, arguments)
	else:
		print("Signal " + signal_name + " not found on target " + target.to_string())
		return Status.FAILURE

	return Status.SUCCESS

