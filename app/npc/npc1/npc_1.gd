extends Node2D

var speed = 1
var normal_speed = 2
var morrendo = false
var _time = 0.0
var girar_para = false

func _ready():
	$AnimatedSprite.frames.set_animation_speed("run", Globals.fator_distancia * 10)
	girar_para =  bool(randi() % 2)

func _physics_process(delta):
	if morrendo:
		_time += delta * 2
		var _x = delta * 3 if girar_para == false else delta * -3
		rotate(_x)
		var curve = (-pow(_time * 2, 2) + (_time * 4))
		position.y -= curve
		position.x -= normal_speed
	else:
		position.x -= speed
	if global_position.x < -16:
		queue_free()

func morri():
	$Area2D.queue_free()
	$AnimatedSprite.play("hit")
	morrendo = true

func _on_Area2D_area_entered(area):
	if area.is_in_group("lazer"):
		morri()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if body.motion.y > 10:
			morri()
