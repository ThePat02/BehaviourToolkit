extends Node2D


@export var global_blackboard: Blackboard


func _ready():
	# Fill the global blackboard with the locations
	global_blackboard.set_value("locations", $Locations.get_children())
