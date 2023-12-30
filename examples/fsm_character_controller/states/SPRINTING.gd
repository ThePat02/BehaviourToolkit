extends FSMState


# Executes after the state is entered.
func _on_enter(actor, _blackboard: Blackboard):
	# Cast actor
	actor = actor as CharacterBody2D

	actor.particles_walking.emitting = true


# Executes every _process call, if the state is active.
func _on_update(_delta: float, actor: Node, _blackboard: Blackboard) -> void:
	# Cast actor
	actor = actor as CharacterBody2D

	actor.velocity = actor.movement_direction * actor.SPEED * actor.SPRINT_MULTIPLIER

	# Flip the sprite if the actor is moving right.
	if actor.velocity.x < 0:
		actor.sprite.flip_h = true
	else:
		actor.sprite.flip_h = false

	actor.move_and_slide()


# Executes before the state is exited.
func _on_exit(actor, _blackboard: Blackboard):
	# Cast actor
	actor = actor as CharacterBody2D

	actor.particles_walking.emitting = false

