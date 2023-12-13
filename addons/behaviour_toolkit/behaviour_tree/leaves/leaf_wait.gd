@icon("res://addons/behaviour_toolkit/icons/BTLeafWait.svg")
class_name LeafWait extends BTLeaf


@export var wait_for_ticks: int = 100


var ticks: int = 0


func tick(_delta: float, _actor: Node, _blackboard: Blackboard):
	if ticks < wait_for_ticks:
		ticks += 1
		return BTStatus.RUNNING
	else:
		ticks = 0
		return BTStatus.SUCCESS
