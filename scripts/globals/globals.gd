extends Node

var activated_endless = true
var arrows = 1 setget set_arrows, get_arrows
var score = 0 	setget set_score, get_score
var level = 1 	setget set_level, get_level

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

func set_arrows(value):
	arrows = value
func get_arrows():
	return arrows

# HELPER METHODS
func add_score(value):
	score += value
func get_fruit_scene(fruit_name):
	return load("res://scenes/fruits/" + fruit_name + ".tscn")