extends Node2D

# Objects scenes
var playerScene = null
var player = null

var spawnerScene = null
var spawners = Array()

var max_spawn = 2
var spawn_count = 0

# onready variables
onready var fruit_container = $Enemy_Container
var current_scene = "EndlessStage"

# Spawner Position
enum position_type {top, bottom, right}
# Fruit list
var possible_fruits_to_create = 1
var fruits_scn = [
	"res://scenes/fruits/Apple.tscn",
	"res://scenes/fruits/Banana.tscn",
	"res://scenes/fruits/Cherry.tscn",
	"res://scenes/fruits/Grapes.tscn",
	"res://scenes/fruits/Kiwi.tscn",
	"res://scenes/fruits/Pineapple.tscn",
	"res://scenes/fruits/Strawberry.tscn",
	"res://scenes/fruits/Unripe_Grapes.tscn"
];

# Called when the node enters the scene tree for the first time.
func _ready():
	spawnerScene = load("res://scenes/misc/Spawner.tscn")
	playerScene = load("res://scenes/characters/Hammond.tscn")
	get_tree().get_root().get_node(current_scene + "/GUI").update_endless_stage()
	$ChallengePanel.show_endless_mode_message()
	set_process(false)
	pass

func _process(delta):
	
	if (player != null):

		# checks if there are active arrows in the screen
		var is_there_an_active_arrow = get_tree().get_nodes_in_group("Arrows").size() == 0

		# MOVE TO NEXT WAVE
		# player is playing
		# player no enemies in the screen
		# no moving arrows in the screen
		if player.state == "PLAYING" && spawn_count == max_spawn && fruit_container.get_child_count() == 0 && is_there_an_active_arrow:
			# show game over message
			globals.set_wave(globals.get_wave() + 1)
			get_tree().get_root().get_node(current_scene + "/GUI").update_endless_stage()
			
			var current_wave = globals.get_wave()
			if current_wave < 10:
				AddFruitSpawner()
				# Adjust max spawn every new wave
				max_spawn = max_spawn + int(max_spawn * 1.5)
				prints("max_spawn", max_spawn)
				prints("current_wave", current_wave)
				
				# Add new fruit to the list when wave count is divisible by 3
				if possible_fruits_to_create != fruits_scn.size() && current_wave % 3 == 0:
					possible_fruits_to_create += 1
	pass

func _on_ChallengePanel_start_game():
	AddPlayerToScene()
	AddFruitSpawner()
	
	set_process(true)
	pass

# ADD PLAYER TO THE SCENE
func AddPlayerToScene():
	player = playerScene.instance()
	player.position = Vector2(player.position.x + 60, player.position.y + 250)
	player.enable_process(false)
	player.state = "PLAYING"
	player.current_scene = current_scene
	self.add_child(player)
	pass

# ADD SPAWNER TO THE SCENE
func AddFruitSpawner():
	var spawnerObject = spawnerScene.instance()
	spawnerObject.connect("create_fruit", self, "on_create_random_fruit")
	$Spawners.add_child(spawnerObject)

func on_create_random_fruit(spawner_type, spawner_position):
	randomize()
	var fruit = load(fruits_scn[randi() % possible_fruits_to_create]).instance()
	fruit.position = spawner_position
	fruit.is_endless_mode = true
	if spawner_type == position_type.right:
		fruit.is_vertical = false
	elif spawner_type == position_type.top:
		fruit.speed = fruit.speed * -1
	spawn_count += 1
	fruit_container.add_child(fruit)
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
		fruit_container, fruitScene, fruitName, 10, 400, 1000, 300, 500, 1, false)
	elif (selected == 1):
		enemy_generator.GenerateHorizontalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 500, 300, 1, false)
		pass
	elif (selected == 2):
		enemy_generator.GenerateVerticalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 500, 200, 1, false)
		pass
	elif (selected == 3):
		enemy_generator.GenerateDiagonalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 300, 150, "\\", 1, false)
		pass
	elif (selected == 4):
		enemy_generator.GenerateDiagonalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 900, 150, "/", 1, false)
		pass
	elif (selected == 5):
		enemy_generator.GenerateRandomPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 400, 1000, 300, 500, 1, true)
	elif (selected == 6):
		enemy_generator.GenerateHorizontalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 500, 300, 1, true)
		pass
	elif (selected == 7):
		enemy_generator.GenerateVerticalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 500, 200, 1, true)
		pass
	elif (selected == 8):
		enemy_generator.GenerateDiagonalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 300, 150, "\\", 1, true)
		pass
	elif (selected == 9):
		enemy_generator.GenerateDiagonalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 900, 150, "/", 1, true)
		pass
	elif (selected == 10):
		enemy_generator.GenerateRandomPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 400, 1000, 300, 500, -1, false)
	elif (selected == 11):
		enemy_generator.GenerateHorizontalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 500, 300, -1, false)
		pass
	elif (selected == 12):
		enemy_generator.GenerateVerticalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 500, 200, -1, false)
		pass
	elif (selected == 13):
		enemy_generator.GenerateDiagonalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 300, 150, "\\", -1, false)
		pass
	elif (selected == 14):
		enemy_generator.GenerateDiagonalPositionEnemy(
		fruit_container, fruitScene, fruitName, 10, 900, 150, "/", -1, false)
		pass
	elif (selected == 15):
		enemy_generator.GenerateRandomPositionHorizontalMovementEnemy(
		fruit_container, fruitScene, fruitName, 10, 1024, 3000, 100, 500, 1, false)
		pass
	print(selected)
	pass # Replace with function body.

func _on_Clear_button_up():
	for enemy in enemy_generator.get_children():
		enemy.queue_free()
	pass # Replace with function body.
