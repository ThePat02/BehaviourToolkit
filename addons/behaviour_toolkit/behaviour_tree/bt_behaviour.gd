@icon("res://addons/behaviour_toolkit/icons/BTBehaviour.svg")
class_name BTBehaviour extends BehaviourToolkit
## Base class for building behaviour nodes in BehaviourToolkit.
##
## Behaviours can return [enum BTBehaviour.BTStatus.SUCCESS],
## [enum BTBehaviour.BTStatus.FAILURE] or [enum BTBehaviour.BTStatus.RUNNING]
## which control the flow of the behaviours in Behaviour Tree system.


enum BTStatus {
	SUCCESS,
	FAILURE,
	RUNNING,
}
