class_name BTShuffledSequence extends BTComposite


func tick(actor: Node, blackboard: Blackboard):
    leaves.shuffle()
    for leaf in leaves:
        var response = leaf.tick(actor, blackboard)

        if response != Status.SUCCESS:
            return response
    
    return Status.SUCCESS
