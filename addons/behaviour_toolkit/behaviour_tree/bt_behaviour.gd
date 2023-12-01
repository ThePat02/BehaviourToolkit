@icon("res://addons/behaviour_toolkit/icons/BTBehaviour.svg")
class_name BTBehaviour extends BehaviourToolkit
## Base class for Behaviours used in the behaviour tree.
##
## TODO


## Status enum returned by nodes executing behaviours.
enum BTStatus {
	SUCCESS,
	FAILURE,
	RUNNING
}
