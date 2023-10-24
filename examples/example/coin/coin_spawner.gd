extends Area2D


const coin = preload("res://examples/example/coin/coin.tscn")


@export var max_coins := 10


@onready var collision_shape = $CollisionShape2D


func _ready():
	for i in range(max_coins):
		spawn_coin()


func _process(_delta):
	if get_child_count() == 1:
		for i in range(max_coins - 4):
			spawn_coin()


func spawn_coin():
	var coin_instance = coin.instantiate()

	coin_instance.position.x = randf_range(collision_shape.shape.extents.x, -collision_shape.shape.extents.x)
	coin_instance.position.y = randf_range(collision_shape.shape.extents.y, -collision_shape.shape.extents.y)

	add_child(coin_instance)

