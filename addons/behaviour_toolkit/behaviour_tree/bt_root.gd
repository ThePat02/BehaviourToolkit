@icon("res://addons/behaviour_toolkit/icons/BTRoot.svg")
class_name BTRoot extends BehaviourToolkit
## Node used as a base parent (root) of a Behaviour Tree


enum ProcessType {
	IDLE, ## Updates on every rendered frame (at current FPS).
	PHYSICS ## Updates on a fixed rate (60 FPS by default) synchornized with physics thread. 
}


@export var autostart: bool = false

## Can be used to select if Behaviour Tree tick() is calculated on
## rendering (IDLE) frame or physics (PHYSICS) frame. 
## [br]
## More info: [method Node._process] and [method Node._physics_process]
@export var process_type: ProcessType = ProcessType.PHYSICS:
	set(value):
		process_type = value
		_setup_processing()

@export var actor: Node
@export var blackboard: Blackboard


var active: bool = false
var current_status: BTBehaviour.Status


@onready var entry_point = get_child(0)


func _ready() -> void:
	if blackboard == null:
		blackboard = _create_local_blackboard()

	if autostart:
		active = true

	if not process_type:
		process_type = ProcessType.PHYSICS

	_setup_processing()


func  _physics_process(delta: float) -> void:
	_process_code(delta)


func _process(delta: float) -> void:
	_process_code(delta)


func _process_code(delta: float) -> void:
	if not active:
		return
	
	blackboard.set_value("delta", delta)
	current_status = entry_point.tick(actor, blackboard)


func _create_local_blackboard() -> Blackboard:
	var blackboard: Blackboard = Blackboard.new()
	return blackboard


# Configures process type to use, if BTree is not active both are disabled.
func _setup_processing() -> void:
	set_physics_process(process_type == ProcessType.PHYSICS)
	set_process(process_type == ProcessType.IDLE)
