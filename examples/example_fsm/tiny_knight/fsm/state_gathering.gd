# State: Gathering
extends FSMState


@export var actor: CharacterBody2D


## Executes after the state is entered.
func _on_enter() -> void:
	print("State: Gathering")
	actor.animation_player.play("walking")


## Executes every _process call, if the state is active.
func _on_update() -> void:
	if not actor.has_reached_target():
		return

	# Get all objects in the group "coin"
	var coins = get_tree().get_nodes_in_group("coin")

	# Find the nearest coin
	var nearest_coin = null
	var nearest_coin_distance = 0
	for coin in coins:
		var distance = actor.global_position.distance_to(coin.global_position)
		if nearest_coin == null or distance < nearest_coin_distance:
			nearest_coin = coin
			nearest_coin_distance = distance
	
	# If there is a coin, move towards it
	if nearest_coin != null:
		actor.move_to_position(nearest_coin.global_position)


## Executes before the state is exited.
func _on_exit() -> void:
	pass
