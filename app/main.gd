extends Control

var start = false
var _time = 0.0
var loading_data = false
var position_x = 0

func _process(delta):
	_time += delta
	if _time > 6.28:
		_time = 0.0
	$score.rect_rotation = lerp($score.rect_rotation, cos(_time * 2) * 2, delta * 2)
	$score.rect_position.y = lerp($score.rect_position.y, 232 + (cos(_time ) * 10), delta * 2)
	if start == true:
		$fade.color.a = lerp($fade.color.a, 1.0, delta * 5)
	if Globals.loading_data:
		if not loading_data:
			loading_data = true
			$score.visible = true if Globals.score != 0 else false
			$score/Label.text = "record: " + String( int(Globals.score) ) + ' m'
			if Globals.can_music_play:
				$AudioStreamPlayer.play()
	rect_position.x = lerp(rect_position.x, position_x, delta * 10)
	
	$can_fx_play/icon.visible = Globals.can_audio_fx_play
	$can_fx_play/icon2.visible = !Globals.can_audio_fx_play
	$can_music_play/icon.visible = Globals.can_music_play
	$can_music_play/icon2.visible = !Globals.can_music_play

func _on_start_pressed():
	if Globals.can_audio_fx_play:
		$click_audio.play()
	start = true
	$start.visible = false
	$quit.visible = false
	$background/personagem.play("click")
	yield(get_tree().create_timer(0.8), "timeout")
	get_tree().change_scene("res://app/gameplay/gameplay.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _on_can_music_play_pressed():
	Globals.can_music_play = !Globals.can_music_play
	Globals.save_score()
	if Globals.can_music_play:
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()

func _on_can_fx_play_pressed():
	Globals.can_audio_fx_play = !Globals.can_audio_fx_play
	Globals.save_score()

func _on_tutorial_btn_pressed():
	position_x = 512

func _on_Button_pressed():
	position_x = 0
