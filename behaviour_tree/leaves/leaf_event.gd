@tool
class_name LeafFSMEvent extends BTLeafIntegration
## This node fires an event on a specified state machine.


@export var event: StringName:
	set(value):
		event = value
		update_configuration_warnings()
@export var return_status: BTStatus = BTStatus.SUCCESS


func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	state_machine.fire_event(event)
	return return_status


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	if event == "":
		warnings.append("Event is empty.")

	return warnings
