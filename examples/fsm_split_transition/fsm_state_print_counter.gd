@tool
extends FSMState


# Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	if _blackboard.get_value("counter") == null:
		_blackboard.set_value("counter", 0)

	var counter: int = _blackboard.get_value("counter")
	if counter == null:
		print(0)
	else:
		print(counter)

## Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	var counter: int = _blackboard.get_value("counter")
	_blackboard.set_value("counter", counter + 1)
