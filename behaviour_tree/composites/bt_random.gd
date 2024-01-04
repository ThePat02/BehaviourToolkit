@icon("res://addons/behaviour_toolkit/icons/BTCompositeRandom.svg")
class_name BTRandom extends BTComposite
## Randomly selects a child to run.


@export var use_seed: bool = false
@export var seed: String = ""


var rng = RandomNumberGenerator.new()
var active_leave: BTBehaviour


func _ready():
	if use_seed:
		rng.seed = hash(seed)


func tick(delta: float, actor: Node, blackboard: Blackboard):
	if active_leave == null:
		active_leave = leaves[rng.randi() % leaves.size()]
	
	var response = active_leave.tick(delta, actor, blackboard)
	
	if response == BTStatus.RUNNING:
		return response
	
	active_leave = null
	return response
