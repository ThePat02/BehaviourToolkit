@tool
extends Control


var current_selection: Node


func _ready():
	%ButtonState.connect("pressed", _on_button_pressed.bind(FSMState))
	%ButtonTransition.connect("pressed", _on_button_pressed.bind(FSMTransition))


func set_current_selection(new_selection):
	current_selection = new_selection


func _on_button_pressed(type):
	var new_node: BehaviourToolkit = type.new()

	current_selection.add_child(new_node)
	new_node.set_owner(current_selection.get_tree().edited_scene_root)
