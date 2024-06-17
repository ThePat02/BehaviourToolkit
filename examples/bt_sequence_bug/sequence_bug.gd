extends Node2D

@onready var finite_state_machine = $FiniteStateMachine

func _on_timer_timeout():
	print("Timer timed out, firing `timeout` event.")
	finite_state_machine.fire_event("timeout")
