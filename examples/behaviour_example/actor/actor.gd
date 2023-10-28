class_name Actor extends CharacterBody2D


@export var movement_speed: float = 200

@export_category("Utility")
@export var navigation_agent: NavigationAgent2D
@export var animation_player: AnimationPlayer
@export_category("BehaviourToolkit")
@export var state_machine: FiniteStateMachine
@export var behaviour_tree: BTRoot


func _ready():
	navigation_agent.connect("velocity_computed", _on_velocity_computed)


func move_to(target: Vector2) -> void:
	state_machine.fire_event("start_walking")
	navigation_agent.target_position = target


func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		state_machine.fire_event("stop_walking")
		return

	var next_position = navigation_agent.get_next_path_position()
	
	var new_velocity: Vector2 = (next_position - position).normalized() * movement_speed

	navigation_agent.set_velocity(new_velocity)


func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()
