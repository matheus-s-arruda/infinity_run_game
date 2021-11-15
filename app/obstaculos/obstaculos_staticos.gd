extends Node2D

var initial_pos = 0
var _shader_interpole = 0.0
var girar_para = false
var destruido = false
var altura = 0

func _ready():
	initial_pos = position.x
	girar_para =  bool(randi() % 2)
	position.y = -altura

func _physics_process(delta):
	position.x -= Globals.fator_distancia * 2
	
	if global_position.x < -16:
		queue_free()
