@tool
extends Control


var current_selection: Node


func _ready():
	# Get current version of the plugin
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("res://addons/behaviour_toolkit/plugin.cfg")
	
	# If the file didn't load, ignore it.
	if err != OK:
		return
	
	var plugin_version = config.get_value("plugin", "version")

	%Version.text = "BehaviourToolkit v" + str(plugin_version)
	
	config.clear()

	# Connect buttons
	%ButtonState.connect("pressed", _on_button_pressed.bind(FSMState))
	%ButtonTransition.connect("pressed", _on_button_pressed.bind(FSMTransition))


func set_current_selection(new_selection):
	current_selection = new_selection


func _on_button_pressed(type):
	var new_node: BehaviourToolkit = type.new()

	current_selection.add_child(new_node)
	new_node.set_owner(current_selection.get_tree().edited_scene_root)
