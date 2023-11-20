extends EditorProperty


var container := VBoxContainer.new()
var ui_type_selector := OptionButton.new()
var container_property_control := VBoxContainer.new()
var property_line_edit := LineEdit.new()
var container_property_vector:= HBoxContainer.new()
var property_vector_x := LineEdit.new()
var property_vector_y := LineEdit.new()
var property_vector_z := LineEdit.new()
var property_color_picker := ColorPicker.new()


func _init():
	# Add containter
	add_child(container)

	# Add UI type selector
	for type in LeafTween.TweenValueType.keys():
		ui_type_selector.add_item(str(type))
	container.add_child(ui_type_selector)

	ui_type_selector.connect("item_selected", _on_item_selected)

	# Add container property control
	container.add_child(container_property_control)

	# Add property controls
	# Line edit
	container_property_control.add_child(property_line_edit)
	property_line_edit.hide()

	# Vector edit
	container_property_control.add_child(container_property_vector)

	property_vector_x.placeholder_text = "X"
	property_vector_x.alignment = HORIZONTAL_ALIGNMENT_CENTER
	container_property_vector.add_child(property_vector_x)

	property_vector_y.placeholder_text = "Y"
	property_vector_y.alignment = HORIZONTAL_ALIGNMENT_CENTER
	container_property_vector.add_child(property_vector_y)

	property_vector_z.placeholder_text = "Z"
	property_vector_z.alignment = HORIZONTAL_ALIGNMENT_CENTER
	container_property_vector.add_child(property_vector_z)

	container_property_vector.hide()

	# Color picker
	container_property_control.add_child(property_color_picker)
	property_color_picker.hide()

	# Update visibility
	update_visbility(ui_type_selector.selected)


func update_visbility(selected_item: int):
	# Hide all
	property_line_edit.hide()
	container_property_vector.hide()
	property_color_picker.hide()

	match selected_item:
		0:
			property_line_edit.show()
		1:
			property_line_edit.show()
		2:
			container_property_vector.show()
			property_vector_z.hide()
		3:
			container_property_vector.show()
			property_vector_z.show()
		4:
			property_color_picker.show()


func _update_property():
	var new_value = get_edited_object()[get_edited_property()]
	if new_value == ui_type_selector.selected:
		return
	
	ui_type_selector.selected = new_value
	update_visbility(new_value)


func _on_item_selected(index: int):
	emit_changed(get_edited_property(), index)
	update_visbility(index)
