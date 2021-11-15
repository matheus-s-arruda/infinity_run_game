extends KinematicBody2D

var initial_position = 80
var GRAVITY = 490
var motion := Vector2(0,0)
var jump_force = 200
var jump_input = 0
var hit = false
var _time = 0
var _flag = false

var chegando_agora = false

func _ready():
	initial_position = global_position.x

func _process(delta):
	$AnimatedSprite.frames.set_animation_speed("run", Globals.fator_distancia * 10)
	if hit == true:
		_time += delta
		$AnimatedSprite.play("hit")
		if _flag == false:
			_flag = true
			if Globals.can_audio_fx_play:
				$hit_audio.play()
			motion.y = -jump_force
			motion.x = -80
		if _time > 0.80:
			_time = 0
			_flag = false
			hit = false
	else:
		if is_on_floor():
			$AnimatedSprite.play("run")
		elif abs(motion.y) > 3: 
			$AnimatedSprite.play("jump")

func _physics_process(delta):
	if is_on_floor():
		chegando_agora = true
		if hit == false:
			if Globals.jump_screen_btn:
				motion.y = 1 * -jump_force
				if Globals.can_audio_fx_play:
					$jump_audio.play()
			else:
				motion.y = 0
	else:
		motion.y += GRAVITY * delta
	if global_position.x != initial_position and hit == false:
		motion.x = 10 if global_position.x < initial_position else -10
	move_and_slide(motion, Vector2.UP)

func end_game():
		var duplicata = $AnimatedSprite.duplicate()
		if Globals.can_audio_fx_play:
			get_parent().get_parent().get_node("player_resquicio").get_node("die_audio").play()
		get_parent().get_parent().get_node("player_resquicio").add_child(duplicata)
		duplicata.global_position = $AnimatedSprite.global_position
		duplicata.play("queimando")
		
		if Globals.vida == 0:
			get_parent().get_parent().end_game() 
		else:
			get_parent().get_parent().respawnar_novo_player()
			Globals.vida -= 1
		queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("obstaculo"):
		if hit == false and chegando_agora:
			hit = true
	if area.is_in_group("lazer"):
		$Area2D.queue_free()
		end_game()

