extends Node

var score_file = "user://data.save"
var _data = []

var distancia = 0
var fator_distancia = 2
var vida = 0

var audio_vida_node
var jump_screen_btn = false

var score = 0
var can_music_play = true
var can_audio_fx_play = true
var loading_data = false

func _ready():
	load_score()

func load_score():
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		_data = f.get_var()
		f.close()
		score = _data[0]
		can_music_play = _data[1]
		can_audio_fx_play = _data[2]
	else:
		score = 0
		can_music_play = true
		can_audio_fx_play = true
	loading_data = true

func save_score():
	_data = [ score, can_music_play, can_audio_fx_play ]
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_var(_data)
	f.close()
