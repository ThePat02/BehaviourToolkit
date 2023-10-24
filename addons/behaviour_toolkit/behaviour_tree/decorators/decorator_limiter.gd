class_name LimiterDecorator extends BTDecorator


@export var limit: int = 1


@onready var cache_key = 'limiter_%s' % self.get_instance_id()


func tick(actor: Node, blackboard: Blackboard):
    var current_count = blackboard.get_value(cache_key)
    if current_count == null:
        current_count = 0
    
    if current_count < limit:
        blackboard.set_value(cache_key, current_count + 1)
        return leaf.tick(actor, blackboard)
    else:
        return Status.FAILURE
