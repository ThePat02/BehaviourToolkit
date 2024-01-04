@tool
extends EditorPlugin


var _editor_interface = get_editor_interface()
var _undo_redo = get_undo_redo()


var _ui_canvas: Control
var _ui_spatial: Control


var _inspector_plugin = preload("res://addons/behaviour_toolkit/inspector_plugin.gd")
var _toolkit_ui = preload("res://addons/behaviour_toolkit/ui/toolkit_ui.tscn")


func _enter_tree():
	_ui_canvas = _toolkit_ui.instantiate()
	_ui_spatial = _toolkit_ui.instantiate()

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

	# Connect editor signals 
	_editor_interface.get_selection().selection_changed.connect(_on_selection_changed)

	# Add inspector plugin
	_inspector_plugin = _inspector_plugin.new()
	add_inspector_plugin(_inspector_plugin)



func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_CANVAS_EDITOR_SIDE_LEFT,_ui_canvas)
	remove_control_from_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_SIDE_LEFT, _ui_spatial)

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
		if node is BehaviourToolkit:
			_ui_canvas.visible = true
			_ui_spatial.visible = true
			return

	_ui_canvas.visible = false
	_ui_spatial.visible = false            
