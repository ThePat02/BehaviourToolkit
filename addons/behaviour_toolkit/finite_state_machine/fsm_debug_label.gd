@tool
class_name FSMDebugLabel extends Label
## Simple label that displays the current state of a FiniteStateMachine.


## The FiniteStateMachine to display the current state of.
@export var state_machine: FiniteStateMachine:
    set(value):
        state_machine = value
        update_configuration_warnings()


func _ready():
    if Engine.is_editor_hint():
        return

    if not state_machine:
        push_warning("FSMDebugLabel missing reference to FiniteStateMachine.")

    state_machine.state_changed.connect(_on_sate_machine_state_changed)


func _on_sate_machine_state_changed(state: FSMState) -> void:
    text = state.name



func _get_configuration_warnings():
    var warnings: PackedStringArray = []

    if not state_machine:
        warnings.push_back("FSMDebugLabel missing reference to FiniteStateMachine.")

    return warnings
