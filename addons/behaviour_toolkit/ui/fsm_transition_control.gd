@tool
extends LineEdit

## The name of the event, or the path to the script to attach. If `event` begins with 'res://', it will be treated as
## a 'script' transition. Otherwise, it is treated as a 'simple' named event.
@export var event: StringName

## The transition to update, if any. If `transition` is `null`, one will be created when a valid node path is entered
## into the edit box. If the edit box is cleared, then this transition is freed, and set to null.
@export var transition: FSMTransition

## The from state. New transitions will be added to this state.
@export var state: FSMState


func _ready():
	_sync_text()

	text_submitted.connect(_on_text_submitted)


func _on_text_submitted(text):
	_on_node_path_selected(NodePath(text))


## Returns the 'basename' of a path. This is usually the filename.
func _get_basename(path: String) -> String:
	var splits := path.rsplit("/", false, 1)
	if splits.size() > 1:
		return splits[1]
	elif splits.size() == 1:
		return splits[0]
	else:
		return ""


## Returns an array of length 2 containing the ['root_name', 'extension']
func _splitext(path: String) -> PackedStringArray:
	var splits := path.rsplit(".", false, 1)
	while splits.size() < 2:
		splits.append("")
	return splits


## Creates a node name for a transition based on a script path.
func _format_event_name_from_script_path(script_path: StringName) -> StringName:
	var name := _get_basename(script_path)
	return _splitext(name)[0].to_pascal_case()


## Creates a new FSMTransition based on given `script_path`.  Note that the next_state attribute is NOT set.
func _create_scripted_fsm_transition(script_path: StringName) -> FSMTransition:
	var transition := FSMTransition.new()
	transition.use_event = false

	var script: Script = load(str(script_path))
	if script.resource_name:
		transition.name = script.resource_name.to_pascal_case()
	else:
		transition.name = _format_event_name_from_script_path(script_path)
	transition.set_script(script)
	return transition


## Creates a 'simple' FSMTransition from the given event name.
func _create_named_event_fsm_transition(event: StringName) -> FSMTransition:
	var transition := FSMTransition.new()
	transition.name = "On" + event.to_pascal_case()
	transition.use_event = true
	transition.event = event
	return transition


## Creates an FSMTransition for the given event name.
func _create_fsm_transition(event: StringName) -> FSMTransition:
	if event.begins_with("res://"):
		return _create_scripted_fsm_transition(event)
	else:
		return _create_named_event_fsm_transition(event)


## Event handler invoked when this cell is updated. If `path` is empty (or falsy), the transition will be deleted.
## If no transition is assigned to this control, one is created and appended to the state.
##
## If the updated node path is invalid, or does not exist, the control is reset to its previous state.
func _on_node_path_selected(path: NodePath):
	if path:
		var fsm: FiniteStateMachine = state.get_parent()
		if fsm:
			var state_to := fsm.get_node(path)
			if state_to:
				if not transition:
					transition = _create_fsm_transition(event)
					state.add_child(transition)
					transition.owner = state.owner

				transition.next_state = state_to

		_sync_text()
	else:
		if transition:
			transition.queue_free()
			transition = null
		_sync_text()


## Sets the text of the label based on this control's current state.
func _sync_text():
	if transition:
		var target = transition.next_state
		text = target.name
	else:
		text = ""
