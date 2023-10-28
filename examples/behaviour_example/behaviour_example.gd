extends Node2D


@export var global_blackboard: Blackboard


func _ready():
	global_blackboard.set_value("locations", $Locations.get_children())
