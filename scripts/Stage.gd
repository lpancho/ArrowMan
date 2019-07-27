extends Node2D

export var environment = ""

# Objects scenes
var playerScene = null

var player = null
var is_last_stage = false
onready var enemy_container = $Enemy_Container

# Signals
signal show_challenge

# Called when the node enters the scene tree for the first time.
func _ready():
	if (environment == "TEST"):
		$TestContainer.visible = true
		
		var options = $TestContainer/VBoxContainer/OptionButton
		options.add_item("GenerateRandomPositionEnemy")
		options.add_item("GenerateHorizontalPositionEnemy")
		options.add_item("GenerateVerticalPositionEnemy")
		options.add_item("GeneratePositiveDiagonalPositionEnemy")
		options.add_item("GenerateNegativeDiagonalPositionEnemy")
		
		# HasBounds = true
#		options.add_separator()
		options.add_item("GenerateRandomPositionEnemyHasBounds")
		options.add_item("GenerateHorizontalPositionEnemyHasBounds")
		options.add_item("GenerateVerticalPositionEnemyHasBounds")
		options.add_item("GeneratePositiveDiagonalPositionEnemyHasBounds")
		options.add_item("GenerateNegativeDiagonalPositionEnemyHasBounds")
		
		# Down Direction
#		options.add_separator()
		options.add_item("GenerateRandomPositionEnemyDownward")
		options.add_item("GenerateHorizontalPositionEnemyDownward")
		options.add_item("GenerateVerticalPositionEnemyDownward")
		options.add_item("GeneratePositiveDiagonalPositionEnemyDownward")
		options.add_item("GenerateNegativeDiagonalPositionEnemyDownward")
		
		# Horizontal Movement
#		options.add_separator()
		options.add_item("GenerateRandomPositionHorizontalMovementEnemy")
		pass
	
	playerScene = load("res://scenes/characters/Hammond.tscn")
	
	# Show Challenge Panel
	$ChallengePanel.show_current_challenge()
	set_process(false)
	pass # Replace with function body.

func _process(delta):
	
	if (player != null):
		
		# checks if there are active arrows in the screen
		var is_there_an_active_arrow = get_tree().get_nodes_in_group("Arrows").size() == 0
		
		# MOVE TO NEXT STAGE
		# player is playing
		# no enemies in the screen
		# no moving arrows in the screen
		if player.state == "PLAYING" && enemy_container.get_child_count() == 0 && is_there_an_active_arrow:
			player.queue_free()
			player = null
			if (is_last_stage):
				$ChallengePanel.show_end_game_message()
			else:
				globals.set_level(globals.get_level() + 1)
				$ChallengePanel.show_current_challenge()
				
		# GAME OVER
		# player is playing
		# player have 0 arrows
		# no moving arrows in the screen
		elif player.state == "PLAYING" && globals.get_arrows() == 0 && is_there_an_active_arrow:
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
	var current_stage = constants.challenges_dict["Stages"][globals.get_level() - 1]
	
	var enemies = current_stage["Enemies"] # First in the list
	for enemy in enemies:
		var fruitScene = globals.get_fruit_scene(enemy["Name"])
		var generator = enemy["Generator"]
		if generator["Name"] == constants.GENERATE_HORIZONTAL_POSITION_ENEMY:
			enemy_generator.GenerateHorizontalPositionEnemy(
			enemy_container, fruitScene, enemy["Name"], enemy["Count"], generator["Position"]["x"], generator["Position"]["y"], generator["Direction"], generator["HasBounds"])
		elif generator["Name"] == constants.GENERATE_VERTICAL_POSITION_ENEMY:
			enemy_generator.GenerateVerticalPositionEnemy(
			enemy_container, fruitScene, enemy["Name"], enemy["Count"], generator["Position"]["x"], generator["Position"]["y"], generator["Direction"], generator["HasBounds"])
		elif generator["Name"] == constants.GENERATE_DIAGONAL_POSITION_ENEMY:
			enemy_generator.GenerateDiagonalPositionEnemy(
			enemy_container, fruitScene, enemy["Name"], enemy["Count"], generator["Position"]["x"], generator["Position"]["y"], generator["Align"], generator["Direction"], generator["HasBounds"])
		elif generator["Name"] == constants.GENERATE_RANDOM_POSITION_HORIZONTALMOVEMENT_ENEMY:
			enemy_generator.GenerateRandomPositionHorizontalMovementEnemy(
			enemy_container, fruitScene, enemy["Name"], enemy["Count"], 
			generator["Position"]["RangeX"]["x"], generator["Position"]["RangeX"]["y"], 
			generator["Position"]["RangeY"]["x"], generator["Position"]["RangeY"]["y"], 
			generator["Direction"], generator["HasBounds"])
		elif generator["Name"] == constants.GENERATE_RANDOM_POSITION_ENEMY:
			enemy_generator.GenerateRandomPositionEnemy(
			enemy_container, fruitScene, enemy["Name"], enemy["Count"], 
			generator["Position"]["RangeX"]["x"], generator["Position"]["RangeX"]["y"], 
			generator["Position"]["RangeY"]["x"], generator["Position"]["RangeY"]["y"], 
			generator["Direction"], generator["HasBounds"])
		elif generator["Name"] == constants.GENERATE_RANDOM_POSITION_VERTICALMOVEMENT_ENEMY:
			enemy_generator.GenerateRandomPositionVerticalMovementEnemy(
			enemy_container, fruitScene, enemy["Name"], enemy["Count"], 
			generator["Position"]["RangeX"]["x"], generator["Position"]["RangeX"]["y"], 
			generator["Position"]["RangeY"]["x"], generator["Position"]["RangeY"]["y"],
			generator["ExtendedBounds"]["RangeY"]["x"], generator["ExtendedBounds"]["RangeY"]["y"],
			generator["Direction"], generator["HasBounds"])
			
	is_last_stage = current_stage["Id"] == constants.LAST_STAGE_ID
	AddPlayerToScene(current_stage["GoldenArrows"])
	get_node("/root/ArrowMan/GUI").update_stage()
	get_node("/root/ArrowMan/GUI").draw_arrows(current_stage["GoldenArrows"])
	set_process(true)
	pass

# ADD PLAYER TO THE SCENE
func AddPlayerToScene(isGoldenArrowActivated):
	player = playerScene.instance()
	player.position = Vector2(player.position.x + 60, player.position.y + 250)
	player.isGoldenArrowActivated = isGoldenArrowActivated
	player.enable_process(false)
	player.state = "PLAYING"
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
