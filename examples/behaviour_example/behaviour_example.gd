extends Node2D


@export var global_blackboard: Blackboard


func _ready():
	# Fill the global blackboard with the locations
	global_blackboard.set_value("locations", $Locations.get_children())
	global_blackboard.set_value("well_area", $WellArea)


func _on_well_area_body_entered(body:Node2D):
	if body is TileMap:
		return

	body.thirst += 10
