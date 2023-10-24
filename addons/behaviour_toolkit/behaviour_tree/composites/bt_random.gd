class_name BTRandom extends BTComposite


@export var use_seed: bool = false
@export var seed: String = ""


var rng = RandomNumberGenerator.new()


func _ready():
    if use_seed:
        rng.seed = hash(seed)


func tick(actor: Node, blackboard: Blackboard):
    var random_leaf = leaves[rng.randi() % leaves.size()]
    var response = random_leaf.tick(actor, blackboard)
    
    return response
