@tool
@icon("res://addons/behaviour_toolkit/icons/BTRoot.svg")
class_name BTRoot extends BehaviourToolkit
## Node used as a base parent (root) of a Behaviour Tree
##
## TODO


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


var active: bool = false:
	set(value):
		active = value
		if value and entry_point != null:
			_setup_processing()
		else:
			set_physics_process(false)
			set_process(false)

var current_status: BTBehaviour.BTStatus


# Connecting signal using @onready to omit the need to use super() call
# in _ready() of extended nodes if they override _ready().
@onready var __connect_child_order_changed: int = child_order_changed.connect(_on_child_order_changed)

@onready var entry_point: BTBehaviour = get_entry_point()


func _validate_property(property: Dictionary) -> void:
	if property.name == "autostart" and get_parent() is FSMStateIntegratedBT:
		autostart = false
		property.usage = PROPERTY_USAGE_NO_EDITOR


func _ready() -> void:
	# Don't run in editor
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process(false)
		return
	
	if blackboard == null:
		blackboard = _create_local_blackboard()
	
	if entry_point == null:
		return
	elif autostart:
		active = true


## Swap this [BTRoot] nodes current entry point with the provided one.
## If root has no [BTBehaviour] as a child the provided one will be added.
## [br][br]
## Old behaviour nodes are freed and the new behaviour will be started on the
## next [code]tick()[/code] callback call.
func swap_entry_point(behaviour: BTBehaviour,
	force_readable_name: bool = false, keep_groups: bool = false) -> void:
	
	if keep_groups == true and entry_point != null:
		for g in entry_point.get_groups():
			if not behaviour.is_in_group(g):
				behaviour.add_to_group(g, true)
	
	if entry_point == null:
		add_child(behaviour, force_readable_name)
	else:
		entry_point.queue_free()
		add_child(behaviour, force_readable_name)


func  _physics_process(delta: float) -> void:
	_process_code(delta)


func _process(delta: float) -> void:
	_process_code(delta)


func _process_code(delta: float) -> void:
	# TODO Would be nice to remove it in future and make use of set_process()
	# and set_physics_process()
	if not active:
		return
	
	current_status = entry_point.tick(delta, actor, blackboard)


func _create_local_blackboard() -> Blackboard:
	var blackboard: Blackboard = Blackboard.new()
	return blackboard


# Configures process type to use, if BTree is not active both are disabled.
func _setup_processing() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false)
		set_process(false)
		return
	
	set_physics_process(process_type == ProcessType.PHYSICS)
	set_process(process_type == ProcessType.IDLE)


func get_entry_point() -> BTBehaviour:
	var first_child := get_child(0)
	if first_child is BTBehaviour:
		return first_child
	else:
		return null


func _on_child_order_changed() -> void:
	if Engine.is_editor_hint():
		return
	
	entry_point = get_entry_point()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []
	
	var children = get_children()

	if children.size() == 0:
		warnings.append("Behaviour Tree needs to have a Behaviour child to work.")
	elif children.size() == 1:
		if not children[0] is BTBehaviour:
			warnings.append("The child of Behaviour Tree needs to be a BTBehaviour.")
	elif children.size() > 1:
		warnings.append("Behaviour Tree has more than one child. Only the first child will be used, other sibilings will be ingored.")

	return warnings
