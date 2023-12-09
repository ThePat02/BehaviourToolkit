extends CharacterBody2D


const SPEED := 100.0


var movement_direction := Vector2.ZERO


@onready var sprite := $Sprite2D


func _physics_process(_delta):
	movement_direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
