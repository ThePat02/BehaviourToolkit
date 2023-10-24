@icon("res://addons/behaviour_toolkit/icons/BTRoot.svg")
class_name BTRoot extends BehaviourToolkit


@export var autostart: bool = true
@export var active: bool = true
@export var actor: Node


@onready var blackboard: Blackboard = Blackboard.new()
@onready var entry_point = get_child(0)


func _ready():
	if not autostart:
		active = false


func _process(delta):
	if not active:
		return
	
	blackboard.set_value("delta", delta)
	entry_point.tick(actor, blackboard)
