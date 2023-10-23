class_name Behaviour extends BehaviourToolkit


var status: Status


# Called once, immediately before the first call to the behavior’s update method. 
func _on_initialize() -> void:
    pass


# Called  exactly  once  each  time  the  behavior  tree  is  updated.
func _on_update() -> Status:
    return Status.SUCCESS


# Called  once,  immediately  after  the  previous  update signals it’s no longer running.
func _on_terminate() -> void:
    pass
