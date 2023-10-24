extends Area2D


@onready var particles = $GPUParticles2D
@onready var timer = $Timer


var last_body


func _on_body_entered(body:Node2D):
	if body.coins != body.max_coins:
		return
	
	last_body = body

	particles.amount = body.coins
	body.coins = 0
	timer.start()
	body.animation_player.play("collect")
	particles.emitting = true
	

    


func _on_timer_timeout():
	last_body.fsm.fire_event("unloaded")
