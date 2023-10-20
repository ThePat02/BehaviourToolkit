extends Area2D


func _ready():
	scale = Vector2(0, 0)

	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), .2)
	print(scale)


func _on_body_entered(body:Node2D):
	body.collect_coin(self)
