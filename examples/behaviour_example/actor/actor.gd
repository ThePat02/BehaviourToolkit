extends CharacterBody2D


@export var age: int = 1
@export var death_age: int = 100
@export var movement_speed: float = 200
@export_range(0, 100) var thirst: int = 100
@export var alive: bool = true

@export_category("Utility")
@export var navigation_agent: NavigationAgent2D
@export var animation_player: AnimationPlayer
@export_category("BehaviourToolkit")
@export var state_machine: FiniteStateMachine
@export var behaviour_tree: BTRoot
@export var ghost_state_machine: FiniteStateMachine


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


func _on_player_tick_timeout():
	if thirst > 0:
		thirst -= 1
	
	age += 1

	if age >= death_age:
		alive = false


func _on_input_event(_viewport:Node, _event:InputEvent, _shape_idx:int):
	ghost_state_machine.fire_event("revive")
