class_name BTSelector extends BTComposite
## Selects the first child that succeeds, or fails if none do.


func tick(actor: Node, blackboard: Blackboard):
    for leaf in leaves:
        var response = leaf.tick(actor, blackboard)

        if response != Status.FAILURE:
            return response
    
    return Status.FAILURE
