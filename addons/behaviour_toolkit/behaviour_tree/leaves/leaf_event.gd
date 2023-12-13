class_name LeafFSMEvent extends BTLeafIntegration
## This node fires an event on a state machine.


@export var event: String
@export var return_status: BTStatus = BTStatus.SUCCESS


func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	state_machine.fire_event(event)
	return return_status
