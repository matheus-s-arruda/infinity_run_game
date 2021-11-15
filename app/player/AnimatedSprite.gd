extends AnimatedSprite

func _on_AnimatedSprite_animation_finished():
	if animation == "queimando":
		queue_free()
