extends Area2D


@onready var animation_player = $AnimationPlayer


func _process(_delta):
    var overlapping_bodies = get_overlapping_bodies()
    $BehaviourTree.blackboard.set_value("overlapping_bodies", overlapping_bodies)
