extends Area2D


func _on_body_entered(body:Node2D):
	body.collect_coin(self)
