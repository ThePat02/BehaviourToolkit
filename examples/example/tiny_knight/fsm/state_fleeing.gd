extends FSMState


@export var actor: CharacterBody2D


## Executes after the state is entered.
func _on_enter():
	print("State: Fleeing")
	actor.sweating.emitting = true


## Executes every _process call, if the state is active.
func _on_update():
	var ghosts = get_tree().get_nodes_in_group("ghost")
	for ghost in ghosts:
		actor.velocity += (actor.position - ghost.position)
	
	actor.velocity = actor.velocity.normalized() * 200
	actor.move_and_slide()

## Executes before the state is exited.
func _on_exit():
	actor.sweating.emitting = false


