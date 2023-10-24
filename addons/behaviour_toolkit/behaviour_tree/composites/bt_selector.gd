class_name BTSelector extends BTComposite


func tick(actor: Node, blackboard: Blackboard):
    for leaf in get_children():
        var response = leaf.tick(actor, blackboard)

        if response != Status.FAILURE:
            return response
    
    return Status.FAILURE
