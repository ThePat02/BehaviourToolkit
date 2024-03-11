@tool
extends EditorPlugin


var _editor_interface = get_editor_interface()
var _undo_redo = get_undo_redo()

const BehaviourToolkitMainScreen = preload("res://addons/behaviour_toolkit/ui/behaviour_toolkit_main_screen.gd")

var _ui_canvas: Control
var _ui_spatial: Control
var _ui_main_screen: BehaviourToolkitMainScreen

var _inspector_plugin = preload("res://addons/behaviour_toolkit/inspector_plugin.gd")
var _toolkit_ui = preload("res://addons/behaviour_toolkit/ui/toolkit_ui.tscn")
var _toolkit_main_screen = preload("res://addons/behaviour_toolkit/ui/behaviour_toolkit_main_screen.tscn")


func _make_visible(visible: bool) -> void:
	if _ui_main_screen:
		_ui_main_screen.visible = visible


func _get_plugin_icon() -> Texture2D:
	return preload("icons/EditorFiniteStateMachine.svg") as Texture2D


func _get_plugin_name():
	return "Behaviour Toolkit"


func _has_main_screen() -> bool:
	return true


func _enter_tree():
	_ui_canvas = _toolkit_ui.instantiate()
	_ui_spatial = _toolkit_ui.instantiate()
	_ui_main_screen = _toolkit_main_screen.instantiate()

	add_control_to_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_SIDE_LEFT,_ui_canvas)
	_ui_canvas.visible = false
	_ui_canvas.editor_interface = _editor_interface
	_ui_canvas.undo_redo = _undo_redo
	_ui_canvas.update_manager.start()
	add_control_to_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_SIDE_LEFT, _ui_spatial)
	_ui_spatial.visible = false
	_ui_spatial.editor_interface = _editor_interface
	_ui_spatial.undo_redo = _undo_redo
	_ui_spatial.update_manager.start()

	_editor_interface.get_editor_main_screen().add_child(_ui_main_screen)
	_ui_main_screen.visible = false

	# Connect editor signals 
	_editor_interface.get_selection().selection_changed.connect(_on_selection_changed)

	# Add inspector plugin
	_inspector_plugin = _inspector_plugin.new()
	add_inspector_plugin(_inspector_plugin)


func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_SIDE_LEFT,_ui_canvas)
	remove_control_from_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_SIDE_LEFT, _ui_spatial)

	if _ui_main_screen:
		_ui_main_screen.queue_free()
	_ui_main_screen = null

	_ui_canvas.queue_free()
	_ui_spatial.queue_free()

	remove_inspector_plugin(_inspector_plugin)


func _on_selection_changed() -> void:

	# Get current selection
	var selection = _editor_interface.get_selection().get_selected_nodes()

	if selection.size() == 0:
		_ui_canvas.visible = false
		_ui_spatial.visible = false
		return
	
	_ui_canvas.set_current_selection(selection[0])
	_ui_spatial.set_current_selection(selection[0])

	for node in selection:
		if node is FiniteStateMachine and _ui_main_screen:
			_ui_main_screen.set_finite_state_machine(node)
		if node is BehaviourToolkit:
			_ui_canvas.visible = true
			_ui_spatial.visible = true
			return

	_ui_canvas.visible = false
	_ui_spatial.visible = false            
