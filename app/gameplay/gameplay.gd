extends Node2D

var distancia = 0
var _time = 0.0
var _end_game = false
var distance_player_laser = 50

func _ready():
	Globals.fator_distancia = 1
	Globals.audio_vida_node = $player_resquicio/vida_audio
	play_music()

func _process(delta):
	_time += delta
	if _time > 6.28:
		_time = 0.0
	
	if not _end_game:
		Globals.fator_distancia += delta / 140
		distancia += 12.5 * delta * Globals.fator_distancia
	lerp_lazer(delta)

func _physics_process(delta):
	if $player_spaw.get_child_count() > 0:
		distance_player_laser = abs($player_spaw.get_child(0).global_position.x) / 3.5
	else:
		distance_player_laser = 50

func end_game():
	if distancia > Globals.score:
		Globals.score = int(distancia)
		$GUI.record()
		Globals.save_score()
	_end_game = true

func play_music():
	if Globals.can_music_play:
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()

func lerp_lazer(delta):
	if _end_game:
		$lazer.position.x = lerp($lazer.position.x, 464, delta * 2)
	else:
		$lazer.position.x = lerp($lazer.position.x, cos(_time) * 6, delta * 10)

func respawnar_novo_player():
	_end_game = false
	yield(get_tree().create_timer(0.3), "timeout")
	var player = preload("res://app/player/player.tscn").instance()
	$player_spaw.add_child(player)
	player.position.y = -260

func _on_AdMob_rewarded(currency, ammount):
	respawnar_novo_player()
	Globals.vida += 1
	$GUI.ads_sucess()

func _on_AdMob_rewarded_video_loaded():
	$AdMob.show_rewarded_video()

func _on_AdMob_rewarded_video_failed_to_load(error_code):
	$GUI.ads_failed()

