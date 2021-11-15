extends Node2D

var altura = 0
var hitted = false
var _time = 0.0

func _ready():
	position.y = -altura

func _physics_process(delta):
	if hitted:
		_time += delta
		if _time < 0.3:
			position.y -= 3
		else:
			queue_free()
	else:
		position.x -= Globals.fator_distancia * 2
	if global_position.x < 0:
		queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		hitted = true
		Globals.vida += 1
		if Globals.audio_vida_node != null and Globals.can_audio_fx_play:
			Globals.audio_vida_node.play()
		$Area2D.queue_free()
