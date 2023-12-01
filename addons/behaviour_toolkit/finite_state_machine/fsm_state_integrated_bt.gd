@tool
@icon("res://addons/behaviour_toolkit/icons/FSMStateIntegration.svg")
class_name FSMStateIntegratedBT extends FSMState
## [FSMState] that can handle and activate [BTRoot] as it's child.
##
## When this [FSMStateIntegratedBT] state is entered it activates it's first
## child of type [BTRoot].
## [br][br]
## If its [BTRoot] is swaped for another [BTRoot] at run-time, the new child
## will be deactivated by default and, if not activated manually, will activate
## automatically next time this state is entered.


@export var fire_event_on_status: bool = false:
	set(value):
		fire_event_on_status = value
		update_configuration_warnings()
@export var on_status: BTBehaviour.BTStatus = BTBehaviour.BTStatus.SUCCESS
@export var event: String:
	set(value):
		event = value
		update_configuration_warnings()


# Connecting signal using @onready to omit the need to use super() call
# in _ready() of extended nodes if they override _ready().
@onready var __connect_child_order_changed: int = \
	child_order_changed.connect(_on_child_order_changed)

@onready var behaviour_tree: BTRoot = _get_behaviour_tree()


## Swap this states current Behaviour Tree with the provided one.
## If state has no [BTRoot] as a child the provided one will be added.
## [br][br]
## Old BTree is freed and the new BTree will be active next time the state will
## be entered.
func swap_behaviour_tree(bt_root: BTRoot,
	force_readable_name: bool = false, keep_groups: bool = false) -> void:
	
	if keep_groups == true and behaviour_tree != null:
		for g in behaviour_tree.get_groups():
			if not bt_root.is_in_group(g):
				bt_root.add_to_group(g, true)
	
	if behaviour_tree == null:
		add_child(bt_root, force_readable_name)
	else:
		behaviour_tree.queue_free()
		add_child(bt_root, force_readable_name)


## Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	if behaviour_tree == null:
		return
	
	behaviour_tree.active = true


## Executes every process call, if the state is active.
func _on_update(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	if behaviour_tree == null:
		return
	
	if behaviour_tree.current_status == on_status and fire_event_on_status:
		get_parent().fire_event(event)


## Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	if behaviour_tree == null:
		return
	
	behaviour_tree.active = false


func _get_behaviour_tree() -> BTRoot:
	# Don't run in editor
	if Engine.is_editor_hint():
		return null

	if get_child_count() == 0:
		return null
	
	for child in get_children():
		if child is BTRoot:
			return child

	return null


func _on_child_order_changed() -> void:
	if Engine.is_editor_hint():
		return
	
	behaviour_tree = _get_behaviour_tree()
	behaviour_tree.autostart = false


func _get_configuration_warnings():
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	var children: Array = get_children()

	var has_root: bool = false
	for child in children:
		if child is BTRoot:
			has_root = true
		elif not child is FSMTransition:
			warnings.append("FSMStateIntegratedBT can only have BTRoot and FSMTransition children.")
	
	if not has_root:
		warnings.append("FSMStateIntegratedBT should have a BTRoot child node to work.")
	
	if fire_event_on_status and event == "":
		warnings.append("FSMStateIntegratedBT has fire_event_on_status enabled, but no event is set.")

	return warnings

