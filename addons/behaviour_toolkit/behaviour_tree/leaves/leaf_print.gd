@icon("res://addons/behaviour_toolkit/icons/BTLeafPrint.svg")
class_name LeafPrint extends BTLeaf


@export var custom_text: String
@export var success: bool = true


func tick(actor: Node, blackboard: Blackboard):
    if custom_text != "":
        print(custom_text)
    else:
        print("Hello World!")
    
    if success:
        return Status.SUCCESS
    
    return Status.FAILURE
