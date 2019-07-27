extends Control

onready var tween = $Tween
var showing = false
signal start_game

var messages
var msg_index = 0

var is_game_over = false
var is_end_game = false

func show_current_challenge():
	showing = true
	print("LEVEL: " + str(globals.get_level()))
	var level = constants.challenges_dict["Stages"][globals.get_level() - 1]
	
	messages = level["Messages"]
	msg_index = 0
	
	$CanvasLayer/Sprite.visible = showing
	$CanvasLayer/Sprite/Text.text = messages[msg_index]
	
	tween.interpolate_property($CanvasLayer/Sprite, "scale", 
		Vector2(0.1, 0.1), Vector2(1, 1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func show_game_over_message():
	is_game_over = true
	showing = true
	messages = constants.game_over_message
	msg_index = 0
	
	$CanvasLayer/Sprite.visible = showing
	$CanvasLayer/Sprite/Text.text = messages[msg_index]
	
	tween.interpolate_property($CanvasLayer/Sprite, "scale", 
		Vector2(0.1, 0.1), Vector2(1, 1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func show_end_game_message():
	is_end_game = true
	showing = true
	messages = constants.end_game_message
	msg_index = 0
	
	$CanvasLayer/Sprite.visible = showing
	$CanvasLayer/Sprite/Text.text = messages[msg_index]
	
	tween.interpolate_property($CanvasLayer/Sprite, "scale", 
		Vector2(0.1, 0.1), Vector2(1, 1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _input(event):
	if (showing):
		if (event.is_action_pressed("ui_select")):
			if (!is_game_over && !is_end_game):
				if (messages.size() == msg_index + 1):
					showing = false
					$CanvasLayer/Sprite.visible = showing
					emit_signal("start_game")
				else:
					msg_index = msg_index + 1
					$CanvasLayer/Sprite/Text.text = messages[msg_index]
			elif is_game_over:
				get_tree().change_scene("res://scenes/menu/MainMenu.tscn")
			elif is_end_game:
				globals.activated_endless = true
				get_tree().change_scene("res://scenes/menu/MainMenu.tscn")
	pass
