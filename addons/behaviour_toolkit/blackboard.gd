class_name Blackboard extends Resource


var content: Dictionary


func set(key: StringName, value: Variant):
    content[key] = value


func get(key: StringName) -> Variant:
    return content[key]
