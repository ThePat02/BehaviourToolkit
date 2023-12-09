extends FSMState


# Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	pass


# Executes every _process call, if the state is active.
func _on_update(_delta: float, actor: Node, _blackboard: Blackboard) -> void:
	actor.velocity = actor.movement_direction * actor.SPEED

	# Flip the sprite if the actor is moving right.
	if actor.velocity.x < 0:
		actor.sprite.flip_h = true
	else:
		actor.sprite.flip_h = false

	actor.move_and_slide()


# Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	pass
