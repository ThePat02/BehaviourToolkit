class_name Blackboard extends Resource
## A blackboard is a dictionary of key/value pairs that can be used to share data between nodes.


## The blackboard's content stored as a dictionary.
@export var content: Dictionary


## Sets a value in the blackboard.
func set_value(key: StringName, value: Variant):
	content[key] = value


## Returns a value from the blackboard. If the key doesn't exist, returns `null`.
func get_value(key: StringName) -> Variant:
	if content.has(key):
		return content[key]
	else:
		return null
