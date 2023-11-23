@icon("res://addons/behaviour_toolkit/icons/BTLeafSignal.svg")
class_name LeafSignal
extends BTLeaf
## Leaf that emits a signal with optional arguments.
## Always returns a SUCCESS.


## Signal emitted on every [code]tick()[/code] by the [LeafSignal].
signal leaf_emitted(arguments_array: Array)


## Array of arguments emitted with the [code]leaf_emitted/code] signal.
@export var arguments: Array = []


func tick(_actor: Node, _blackboard: Blackboard) -> Status:
	emit_signal("leaf_emitted", arguments)
	return Status.SUCCESS

