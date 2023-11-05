extends FSMState


## Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard):
	pass


## Executes every _process call, if the state is active.
func _on_update(_actor: Node, _blackboard: Blackboard):
	pass


## Executes before the state is exited.
func _on_exit(actor: Node, _blackboard: Blackboard):
	actor.set_modulate(Color(1, 1, 1, 1))
