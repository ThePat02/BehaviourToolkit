@tool
@icon("res://addons/behaviour_toolkit/icons/BTRoot.svg")
class_name BTRoot extends BehaviourToolkit
## Node used as a base parent (root) of a Behaviour Tree
##
## This is the root of your behaviour tree.[br]
## It is designed to expect first child node to be a BTComposite node to start
## the execution of the behaviour tree.[br]
## The root node is responsible for updating the tree.


enum ProcessType {
	IDLE, ## Updates on every rendered frame (at current FPS).
	PHYSICS, ## Updates on a fixed rate (60 FPS by default) synchornized with physics thread. 
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
var current_status: BTBehaviour.BTStatus
var entry_point: Node = null


func _ready() -> void:
	# Don't run in editor
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process(false)
		return
	
	entry_point = get_child(0)
	
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
	
	current_status = entry_point.tick(delta, actor, blackboard)


func _create_local_blackboard() -> Blackboard:
	var blackboard: Blackboard = Blackboard.new()
	return blackboard


# Configures process type to use, if BTree is not active both are disabled.
func _setup_processing() -> void:
	set_physics_process(process_type == ProcessType.PHYSICS)
	set_process(process_type == ProcessType.IDLE)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	
	var children = get_children()

	if children.size() == 0:
		warnings.append("Behaviour Tree needs to have one Behaviour child.")
	elif children.size() == 1:
		if not children[0] is BTBehaviour:
			warnings.append("The child of Behaviour Tree needs to be a Behaviour.")
	elif children.size() > 1:
		warnings.append("Behaviour Tree can have only one Behaviour child.")

	return warnings
