@icon("res://addons/behaviour_toolkit/icons/Blackboard.svg")
class_name Blackboard extends Resource
## A blackboard is a dictionary of key/value pairs that can be used to share
## data between nodes.
##
## [Blackboard] can be used by BT plugin nodes to store and pass the data.


## The blackboard's content stored as a dictionary.
@export var content: Dictionary


## Sets a value in the blackboard.
func set_value(key: StringName, value: Variant) -> void:
	content[key] = value


## Returns a value from the blackboard. If the key doesn't exist, returns `null`.
func get_value(key: StringName) -> Variant:
	if content.has(key):
		return content[key]
	else:
		return null


## Removes a value from the blackboard. Returns `true` if the key existed, `false` otherwise.
func remove_value(key: StringName) -> bool:
	return content.erase(key)


## Clears the blackboard and removes all its values.
func clear() -> void:
	content.clear()
