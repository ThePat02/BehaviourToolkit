class_name FSMState
extends BehaviourToolkit
## A state in a [FiniteStateMachine].


## List of transitions from this state.
var transitions: Array[FSMTransition] = []


func _ready() -> void:
    for transition in get_children():
        if transition is FSMTransition:
            transitions.append(transition)

## Executes after the state is entered.
func _on_enter() -> void:
    pass


## Executes every _process call, if the state is active.
func _on_update() -> void:
    pass


## Executes before the state is exited.
func _on_exit() -> void:
    pass
