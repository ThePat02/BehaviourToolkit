extends CharacterBody2D


var coins := 0


@export var speed := 100.0
@export var speed_multiplier := 1.0
@export var max_coins := 10


@onready var fsm: FiniteStateMachine = $FiniteStateMachine
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var sweating: GPUParticles2D = $ParticlesSweat


func _ready():
	fsm.start()


func _process(_delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * speed * speed_multiplier

	velocity = new_velocity

	# Flip sprite if needed
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

	move_and_slide()


func move_to_position(pos: Vector2):
	navigation_agent.target_position = pos


func has_reached_target():
	return navigation_agent.is_navigation_finished()


func collect_coin(coin):
	if not coins >= max_coins:
		animation_player.play("collect")

		coin.remove_from_group("coin")

		var tween = get_tree().create_tween()
		tween.tween_property(coin, "global_position", global_position, .05)
		tween.tween_property(coin, "scale", Vector2(0, 0), .05)
		tween.tween_callback(coin.queue_free)

		
		coins += 1
		animation_player.play("walking")
