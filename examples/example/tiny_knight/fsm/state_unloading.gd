extends FSMState


@export var actor: CharacterBody2D


## Executes after the state is entered.
func _on_enter() -> void:
	print("State: Unloading")
	actor.speed_multiplier = 1.5
	actor.move_to_position(actor.get_parent().get_node("LoadingZone").position)
	actor.particles.emitting = true


func _on_exit() -> void:
	actor.speed_multiplier = 1.0
	actor.particles.emitting = false
