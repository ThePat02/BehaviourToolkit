class_name BTSequence extends BTComposite


func tick(actor: Node, blackboard: Blackboard):
    for leaf in get_children():
        var response = leaf.tick(actor, blackboard)

        if response != Status.SUCCESS:
            return response
    
    return Status.SUCCESS
