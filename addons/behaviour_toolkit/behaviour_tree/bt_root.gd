@icon("res://addons/behaviour_toolkit/icons/BTRoot.svg")
class_name BTRoot extends BehaviourToolkit


@export var autostart: bool = false
var active: bool = false
@export var process_type: ProcessType = ProcessType.PHYSICS
@export var actor: Node
@export var blackboard: Blackboard


@onready var entry_point = get_child(0)


var current_status: BTBehaviour.Status


func _ready():
	if blackboard == null:
		blackboard = _create_local_blackboard()

	if autostart:
		active = true


func _process(delta):
	if not active:
		return
	
	if not process_type == ProcessType.IDLE:
		return

	tick(delta)


func _physics_process(delta):
	if not active:
		return
	
	if not process_type == ProcessType.PHYSICS:
		return

	tick(delta)


func tick(delta):
	blackboard.set_value("delta", delta)
	current_status = entry_point.tick(actor, blackboard)


func _create_local_blackboard() -> Blackboard:
	var blackboard: Blackboard = Blackboard.new()
	return blackboard
