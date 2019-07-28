extends Node2D

# Objects scenes
var playerScene = null
var player = null

# onready variables
onready var enemy_container = $Enemy_Container
var current_scene = "EndlessStage"

# Called when the node enters the scene tree for the first time.
func _ready():
	playerScene = load("res://scenes/characters/Hammond.tscn")
	$ChallengePanel.show_endless_mode_message()
	set_process(false)
	pass

func _process(delta):
	
	if (player != null):
		
		# checks if there are active arrows in the screen
		var is_there_an_active_arrow = get_tree().get_nodes_in_group("Arrows").size() == 0
				
		# GAME OVER
		# player is playing
		# player have 0 arrows
		# no moving arrows in the screen
		if player.state == "PLAYING" && globals.get_arrows() == 0 && is_there_an_active_arrow:
			# remove player
			player.queue_free()
			player = null
			
			# remove enemies
			for enemy in enemy_container.get_children():
				enemy.queue_free()
			
			# show game over message
			$ChallengePanel.show_game_over_message()
	pass

func _on_ChallengePanel_start_game():
	set_process(true)
	AddPlayerToScene(false)
	pass

# ADD PLAYER TO THE SCENE
func AddPlayerToScene(isGoldenArrowActivated):
	player = playerScene.instance()
	player.position = Vector2(player.position.x + 60, player.position.y + 250)
	player.isGoldenArrowActivated = isGoldenArrowActivated
	player.enable_process(false)
	player.state = "PLAYING"
	player.current_scene = current_scene
	self.add_child(player)
	pass

# TESTING PURPOSES
# Set environment = "TEST"
func _on_Generate_button_up():
	var selected = $TestContainer/VBoxContainer/OptionButton.selected
	var fruitScene = load("res://scenes/fruits/Apple.tscn")
	var fruitName = "Apple"
	#	0 = "GenerateRandomPositionEnemy"
	#	1 = "GenerateHorizontalPositionEnemy"
	#	2 = "GenerateVerticalPositionEnemy"
	#	3 = "GeneratePositiveDiagonalPositionEnemy"
	#	4 = "GenerateNegativeDiagonalPositionEnemy"
	
	if (selected == 0):
		enemy_generator.GenerateRandomPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 400, 1000, 300, 500, 1, false)
	elif (selected == 1):
		enemy_generator.GenerateHorizontalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 500, 300, 1, false)
		pass
	elif (selected == 2):
		enemy_generator.GenerateVerticalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 500, 200, 1, false)
		pass
	elif (selected == 3):
		enemy_generator.GenerateDiagonalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 300, 150, "\\", 1, false)
		pass
	elif (selected == 4):
		enemy_generator.GenerateDiagonalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 900, 150, "/", 1, false)
		pass
	elif (selected == 5):
		enemy_generator.GenerateRandomPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 400, 1000, 300, 500, 1, true)
	elif (selected == 6):
		enemy_generator.GenerateHorizontalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 500, 300, 1, true)
		pass
	elif (selected == 7):
		enemy_generator.GenerateVerticalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 500, 200, 1, true)
		pass
	elif (selected == 8):
		enemy_generator.GenerateDiagonalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 300, 150, "\\", 1, true)
		pass
	elif (selected == 9):
		enemy_generator.GenerateDiagonalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 900, 150, "/", 1, true)
		pass
	elif (selected == 10):
		enemy_generator.GenerateRandomPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 400, 1000, 300, 500, -1, false)
	elif (selected == 11):
		enemy_generator.GenerateHorizontalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 500, 300, -1, false)
		pass
	elif (selected == 12):
		enemy_generator.GenerateVerticalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 500, 200, -1, false)
		pass
	elif (selected == 13):
		enemy_generator.GenerateDiagonalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 300, 150, "\\", -1, false)
		pass
	elif (selected == 14):
		enemy_generator.GenerateDiagonalPositionEnemy(
		enemy_container, fruitScene, fruitName, 10, 900, 150, "/", -1, false)
		pass
	elif (selected == 15):
		enemy_generator.GenerateRandomPositionHorizontalMovementEnemy(
		enemy_container, fruitScene, fruitName, 10, 1024, 3000, 100, 500, 1, false)
		pass
	print(selected)
	pass # Replace with function body.

func _on_Clear_button_up():
	for enemy in enemy_generator.get_children():
		enemy.queue_free()
	pass # Replace with function body.
