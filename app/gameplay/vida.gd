extends Control

var heart = preload("res://sprintes/GUI/vida.png")
var vida = 100

func _ready():
	vida = Globals.vida

func _process(delta):
	if Globals.vida != vida:
		vida = Globals.vida
		
		for c in get_children():
			c.queue_free()
		
		for index in range(vida):
			var new_sprite = Sprite.new()
			new_sprite.texture = heart
			add_child(new_sprite)
			new_sprite.scale = Vector2(2, 2)
			new_sprite.position.y = 50
			new_sprite.position.x = (index * 20) - (vida * 10) + 10

