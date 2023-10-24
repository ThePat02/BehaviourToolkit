class_name BTRoot extends BehaviourToolkit


@export var actor: Node


@onready var blackboard: Blackboard = Blackboard.new()
@onready var entry_point = get_child(0)


func _process(delta):
	blackboard.set_value("delta", delta)
	entry_point.tick(actor, blackboard)
