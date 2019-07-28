extends Node

var activated_endless = true
var arrows = 25 setget set_arrows, get_arrows
var score = 0 	setget set_score, get_score
var level = 1 	setget set_level, get_level
var wave = 1	setget set_wave, get_wave
var medal = 0	setget set_medal, get_medal

# SETGET
func set_score(value):
	score = value
	pass
func get_score():
	return score
	
func set_level(value):
	level = value
func get_level():
	return level

func set_wave(value):
	wave = value
func get_wave():
	return wave

func set_medal(value):
	medal = value
func get_medal():
	return medal

func set_arrows(value):
	arrows = value
func get_arrows():
	return arrows

# HELPER METHODS
func add_score(value):
	score += value
func add_medal(value):
	medal += value
func get_fruit_scene(fruit_name):
	return load("res://scenes/fruits/" + fruit_name + ".tscn")