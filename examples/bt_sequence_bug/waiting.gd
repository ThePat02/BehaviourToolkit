extends FSMState

@onready var timer = $"../../Timer"

func _on_enter(_actor, _blackboard: Blackboard):
	print("Waiting")
	timer.start()

func _on_exit(_actor, _blackboard: Blackboard):
	print("Done Waiting")
	timer.stop()
