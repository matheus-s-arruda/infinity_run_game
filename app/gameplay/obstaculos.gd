extends Node2D

var npc = preload("res://app/npc/npc1/npc_1.tscn")

var carro = preload("res://app/obstaculos/carro.tscn")
var passarela = preload("res://app/obstaculos/passarela.tscn")
var caixa = preload("res://app/obstaculos/caixa.tscn")
var placa_1 = preload("res://app/obstaculos/placa_1.tscn")
var placa_2 = preload("res://app/obstaculos/placa_2.tscn")
var plataforma = preload("res://app/obstaculos/plataforma.tscn")
var vida = preload("res://app/player/vida.tscn")

var index = 0
var padrao_obstaculos = [
	[passarela, [placa_1, caixa]],
	[[passarela, [caixa, 30]], passarela, [passarela, caixa]],
	[passarela, passarela, placa_1, placa_1, [[vida, 100]], ], ####
	[passarela, [passarela, caixa], caixa, passarela, carro],
	[passarela, [carro, passarela], placa_2],

	[caixa, 0, placa_1, placa_1, 0, passarela],
	[[passarela, carro], 0, [placa_2, passarela]],
	[carro, 0, placa_1, 0, [carro, placa_2], passarela],
	[caixa, passarela, 0, passarela, [passarela, [caixa, 30]], 0, 0, [[vida, 64]] ],  #####
	[[passarela, carro], carro, 0, placa_1],

	[carro, [caixa, passarela], 0, 0, 0, [carro, placa_2], 0, 0, 0, [carro, placa_2], 0, 0, 0, [passarela, [caixa, 30], placa_2], 0, 0, [carro, placa_2], 0 ],
	[[passarela, caixa, placa_2], [passarela, carro], passarela, [passarela, caixa], passarela, 0, [placa_2]],
	[caixa, passarela, [passarela, caixa, [passarela, 28]], 0, [passarela, [passarela, 28]], placa_2,
		[[plataforma,112]], [[plataforma,112]], [[plataforma,112]], [[plataforma,112]], [[plataforma,112]]],
	[[passarela, caixa], passarela, passarela, [placa_1, caixa], 0, passarela],
	[placa_2, placa_2, [[vida, 112]], placa_1, placa_2, 0, 0, [caixa, placa_2], 0 ], ###
	
	[passarela, passarela, [passarela, carro], [passarela, caixa], [passarela, carro], placa_2, 0],
	[[passarela, placa_2, [passarela, 28]], 0, [passarela, placa_2, [passarela, 28]], [passarela, caixa, placa_2, [passarela, 28]], [passarela, placa_2, [passarela, 28]], carro ],
	[placa_2, placa_2, [placa_2, caixa], placa_2, placa_2, placa_2, placa_2, [placa_2, caixa], placa_2, placa_2, placa_2, [placa_2, placa_1], placa_2],
	
	[
		[caixa, passarela], passarela, passarela, [passarela, carro], [passarela, carro, [caixa, 30]],
		[passarela, [passarela, 28]], [passarela, [passarela, 28], [passarela, 56]], [passarela, [passarela, 28], [passarela, 56]], [ passarela, [passarela, 28]],
		[passarela, [passarela, 28], [passarela, 56], [caixa, 58]], [passarela, [passarela, 28], [passarela, 56], [passarela, 84]],
		[passarela, [passarela, 28], [passarela, 56], [passarela, 84]], [passarela, placa_2, placa_1, [passarela, 28], [passarela, 56], [passarela, 84]],
		[[plataforma,112]], [[plataforma,112]], [[plataforma,112]], [[plataforma,112]], [[plataforma,112]], [[plataforma,112]]
	],
	
	[ [[plataforma, 112]], [[plataforma, 112]], [[plataforma, 112]], [[plataforma, 112]], [caixa, [vida, 160]], [[plataforma, 112]], [[plataforma, 112]], [[plataforma, 112]], [[plataforma, 112]], 0, ],
	[carro, carro, carro, carro, carro, carro, carro, carro, carro, carro],
]

func _ready():
	randomize()
	yield(get_tree().create_timer(1),"timeout")
	spaw_npc()
	spaw_obstaculos()

func spaw_npc():
	var x = randi() % 4
	var new_npc = npc.instance()
	add_child(new_npc)
	new_npc.speed = 0.75 + (randf() / 2)
	$Timer_npc.start(x + 1)

func spaw_obstaculos():
	var _distancia = int((Globals.fator_distancia -1) *6)
	print(_distancia)
	var filtered_list = []

	for index in range(5):
		if _distancia <= padrao_obstaculos.size() - 5:
			filtered_list.append(padrao_obstaculos[index + _distancia])
		else:
			filtered_list.append(padrao_obstaculos[(padrao_obstaculos.size() - 1) - index ])
	var _padrao = filtered_list[randi() % filtered_list.size()]
	
	for e in range(_padrao.size()):
		if _padrao[e] is Object:
			montar_padrao(_padrao[e], e)
		elif _padrao[e] is Array:
			for _e in _padrao[e]:
				if _e is Object:
					montar_padrao(_e, e)
				else:
					montar_padrao(_e[0], e, _e[1])
	
	var fator = 1.0 + (0.5 * _padrao.size())
	
	$Timer.start(fator / Globals.fator_distancia)

func montar_padrao(item, index, altura = 0):
	if get_parent()._end_game:
		return
	var new_item = item.instance()
	new_item.altura = altura
	add_child(new_item)
	new_item.position.x = 64 * index

func _on_Timer_timeout():
	spaw_obstaculos()

func _on_Timer_npc_timeout():
		spaw_npc()
