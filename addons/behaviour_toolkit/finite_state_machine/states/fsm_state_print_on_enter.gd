@tool
@icon("res://addons/behaviour_toolkit/icons/BTLeafPrint.svg")
class_name FSMStatePrintOnEnter extends FSMState

@export var custom_text: String


# Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	if custom_text != "":
		print(custom_text)
	else:
		print("Hello World!")
