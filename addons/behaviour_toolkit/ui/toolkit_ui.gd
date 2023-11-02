@tool
extends Control


var current_selection: Node


func _ready():
	# Get current version of the plugin
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("res://addons/behaviour_toolkit/plugin.cfg")
	
	# If the file didn't load, ignore it.
	if not err != OK:
		var plugin_version = config.get_value("plugin", "version")
		%Version.text = "BehaviourToolkit v" + str(plugin_version)
	
	config.clear()

	# Connect buttons
	%ButtonState.connect("pressed", _on_button_pressed.bind(FSMState, "FSMState"))
	%ButtonTransition.connect("pressed", _on_button_pressed.bind(FSMTransition, "FSMTransition"))

	%ButtonLeaf.connect("pressed", _on_button_pressed.bind(BTLeaf, "BTLeaf"))
	%ButtonPrint.connect("pressed", _on_button_pressed.bind(LeafPrint, "LeafPrint"))
	%ButtonWait.connect("pressed", _on_button_pressed.bind(LeafWait, "LeafWait"))

	%ButtonComposite.connect("pressed", _on_button_pressed.bind(BTComposite, "BTComposite"))
	%ButtonSequence.connect("pressed", _on_button_pressed.bind(BTSequence, "BTSequence"))
	%ButtonSelector.connect("pressed", _on_button_pressed.bind(BTSelector, "BTSelector"))
	%ButtonRandom.connect("pressed", _on_button_pressed.bind(BTRandom, "BTRandom"))
	%ButtonRandomSequence.connect("pressed", _on_button_pressed.bind(BTRandomSequence, "BTRandomSequence"))
	%ButtonRandomSelector.connect("pressed", _on_button_pressed.bind(BTRandomSelector, "BTRandomSelector"))

	%ButtonDecorator.connect("pressed", _on_button_pressed.bind(BTDecorator, "BTDecorator"))
	%ButtonAlwaysFail.connect("pressed", _on_button_pressed.bind(BTAlwaysFail, "BTAlwaysFail"))
	%ButtonAlwaysSucceed.connect("pressed", _on_button_pressed.bind(BTAlwaysSucceed, "BTAlwaysSucceed"))
	%ButtonLimiter.connect("pressed", _on_button_pressed.bind(BTLimiter, "BTLimiter"))
	%ButtonInverter.connect("pressed", _on_button_pressed.bind(BTInverter, "BTInverter"))
	%ButtonRepeat.connect("pressed", _on_button_pressed.bind(BTRepeat, "BTRepeat"))


func set_current_selection(new_selection):
	current_selection = new_selection


func _on_button_pressed(type, name: String):
	var new_node: BehaviourToolkit = type.new()

	# Check if name already exists
	var already_exists = false
	var count = 0
	for child in current_selection.get_children():
		if child.name.begins_with(name):
			count += 1
			already_exists = true

	if not already_exists:
		new_node.name = name
	else:
		new_node.name = name + str(count + 1)


	current_selection.add_child(new_node)
	new_node.set_owner(current_selection.get_tree().edited_scene_root)
