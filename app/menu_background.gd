extends Control

var escuro = preload("res://sprintes/GUI/escuro_background_menu.png")
var luz = preload("res://sprintes/GUI/luz_background_menu.png")

func _ready():
	anime_ciclo()

func anime_ciclo():
	var random = randi() % 20
	
	$luz.texture = luz if random != 1 else escuro
	
	yield(get_tree().create_timer(0.2), "timeout")
	anime_ciclo()
