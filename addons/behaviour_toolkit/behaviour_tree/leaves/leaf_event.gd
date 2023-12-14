class_name LeafFSMEvent extends BTLeafIntegration
## This node fires an event on a state machine.


@export var event: String
@export var return_status: Status = Status.SUCCESS


func tick(_actor: Node, _blackboard: Blackboard) -> Status:
    state_machine.fire_event(event)
    return return_status
