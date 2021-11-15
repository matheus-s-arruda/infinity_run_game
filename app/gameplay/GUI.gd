extends Control

var paused = false

func _ready():
	$top/record.visible = false
	$botton/load_ads.visible = false
	$paused.visible = false
	$fade.visible = true
	$botton.rect_rotation = 24
	$botton.rect_position = Vector2(256, 400)
	$paused/can_fx_btn/icon.visible = Globals.can_audio_fx_play
	$paused/can_fx_btn/icon2.visible = !Globals.can_audio_fx_play
	$paused/can_music_btn/icon.visible = Globals.can_music_play
	$paused/can_music_btn/icon2.visible = !Globals.can_music_play

func _process(delta):
	Globals.jump_screen_btn = $touch_screen.pressed
	if $fade.color.a > 0:
		$fade.color.a = lerp($fade.color.a, 0, delta * 4)
	if not get_parent()._end_game:
		$top/distancia.modulate = Color(1,1,1,1)
		$top/record.modulate = Color(1,1,1,1)
		$top.rect_scale = lerp($top.rect_scale, Vector2(1, 1), delta * 10)
		$top/distancia.text = String(int(get_parent().distancia)) + ' m'
		$botton.rect_position.y = lerp($botton.rect_position.y, 400, delta * 2)
		$pause.visible = true
	else:
		$pause.visible = false
		$top/distancia.modulate = lerp($top/distancia.modulate, Color(0,0,0,1), delta )
		$top/record.modulate = lerp($top/record.modulate, Color(0,0,0,1), delta )
		$top.rect_scale = lerp($top.rect_scale, Vector2(4, 4), delta * 2)
		$botton.rect_position.y = lerp($botton.rect_position.y, 184, delta * 2)
		$botton.rect_rotation = lerp($botton.rect_rotation, cos(get_parent()._time) * 1.5, delta * 2)

func record():
	$top/record.visible = true

func ads_sucess():
	$botton/load_ads.visible = false
	$botton/restart.disabled = false
	$botton/return.disabled = false

func ads_failed():
	$botton/ads.visible = true
	$botton/load_ads.visible = false
	$botton/restart.disabled = false
	$botton/return.disabled = false

func _on_pause_pressed():
	$pause.visible = false
	$paused.visible = true
	get_tree().paused = true

func _on_play_pressed():
	get_tree().paused = false
	$paused.visible = false
	$pause.visible = true

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://app/main.tscn")

func _on_return_pressed():
	get_tree().change_scene("res://app/main.tscn")

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_ads_pressed():
	get_parent().get_node("AdMob").load_rewarded_video()
	$botton/load_ads.visible = true
	$botton/ads.visible = false
	$botton/restart.disabled = true
	$botton/return.disabled = true

func _on_can_music_btn_pressed():
	Globals.can_music_play = !Globals.can_music_play
	Globals.save_score()
	get_parent().play_music()
	$paused/can_music_btn/icon.visible = Globals.can_music_play
	$paused/can_music_btn/icon2.visible = !Globals.can_music_play

func _on_can_fx_btn_pressed():
	Globals.can_audio_fx_play = !Globals.can_audio_fx_play
	Globals.save_score()
	$paused/can_fx_btn/icon.visible = Globals.can_audio_fx_play
	$paused/can_fx_btn/icon2.visible = !Globals.can_audio_fx_play
