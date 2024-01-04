@tool
@icon("res://addons/behaviour_toolkit/icons/FSMStateIntegration.svg")
class_name FSMStateIntegratedBT extends FSMState
## A state in a [FiniteStateMachine] that allows to integrate Behaviour tree
## in State Machines by handling [BTRoot] node.
##
## To nest a Behaviour Tree you need to add a BTRoot as a first child of
## [FSMStateIntegratedBT]. When this state is entered, the Behaviour Tree
## is set to active.
## [br][br]
## You can use the [method FSMStateIntegratedBT.fire_event_on_status property
## to fire an event when the Behaviour Tree returns a specific status.
## This allows you to trigger transitions based on the status of the
## Behaviour Tree. You can also use the [FSMEvent] leaf to trigger custom
## events inside the nested State Machine.


@onready var behaviour_tree: BTRoot = _get_behaviour_tree()


@export var fire_event_on_status: bool = false:
	set(value):
		fire_event_on_status = value
		update_configuration_warnings()
@export var on_status: BTBehaviour.BTStatus = BTBehaviour.BTStatus.SUCCESS
@export var event: String:
	set(value):
		event = value
		update_configuration_warnings()


## Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	behaviour_tree.active = true


## Executes every process call, if the state is active.
func _on_update(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	if behaviour_tree.current_status == on_status:
		if fire_event_on_status:
			get_parent().fire_event(event)


## Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
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


func _get_configuration_warnings() -> PackedStringArray:
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
		warnings.append("FSMStateIntegratedBT must have a BTRoot child node.")

	if fire_event_on_status and event == "":
		warnings.append(
			"FSMStateIntegratedBT has fire_event_on_status enabled, but no event is set."
		)

	return warnings
