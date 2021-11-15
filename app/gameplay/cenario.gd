extends Node2D

func _process(delta):
	paralax(0, 0.05 * Globals.fator_distancia)
	paralax(1, 0.25 * Globals.fator_distancia)
	paralax(2, 1.2 * Globals.fator_distancia)
	paralaxFore(0, 2 * Globals.fator_distancia)

func paralax(index, speed):
	if $ParallaxBackground.get_child(index).position.x > -512 + speed:
		$ParallaxBackground.get_child(index).position.x -= speed
	else:
		$ParallaxBackground.get_child(index).position.x = 0

func paralaxFore(index, speed):
	if $ParallaxForeground.get_child(index).position.x > -512 + speed:
		$ParallaxForeground.get_child(index).position.x -= speed
	else:
		$ParallaxForeground.get_child(index).position.x = 0
