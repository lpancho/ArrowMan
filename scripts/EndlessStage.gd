extends Node2D

# Objects scenes
var playerScene = null
var player = null

var spawnerScene = null
var spawners = Array()

var spawn_hit = 0
var max_spawn = 1
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
	$GUI.update_endless_stage()
	$GUI.update_endless_medal()
	$GUI/CanvasLayer/FruitCount.visible = true
	
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
			spawn_count = 0
			globals.set_wave(globals.get_wave() + 1)
			$GUI.update_endless_stage()
			
			var current_wave = globals.get_wave()
			if current_wave == 2 || current_wave == 5 || current_wave == 8:
				AddFruitSpawner(position_type.top)
			elif current_wave == 3 || current_wave == 6 || current_wave == 9:
				AddFruitSpawner(position_type.bottom)
			elif current_wave == 4 || current_wave == 7 || current_wave == 10:
				AddFruitSpawner(position_type.right)
				
			# Adjust max spawn every new wave
			max_spawn = max_spawn + int(current_wave * 1.5)
			$GUI.update_endless_fruitcount(max_spawn)
			spawn_hit = 0
			
			# Add new fruit to the list when wave count is divisible by 3
			if possible_fruits_to_create != fruits_scn.size() && current_wave % 3 == 0:
				possible_fruits_to_create += 1
	pass

func _on_ChallengePanel_start_game():
	AddPlayerToScene()
	AddFruitSpawner(position_type.right) 	# spawner from right will be added first
	
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
func AddFruitSpawner(spawner_type):
	var spawnerObject = spawnerScene.instance()
	spawnerObject.current_position_type = spawner_type
	spawnerObject.connect("create_fruit", self, "on_create_random_fruit")
	$Spawners.add_child(spawnerObject)

func on_create_random_fruit(spawner_type, spawner_position):
	randomize()
	var fruit = load(fruits_scn[randi() % possible_fruits_to_create]).instance()
	fruit.add_to_group(fruit.name)
	fruit.connect("hit_fruit", self, "on_hit_fruit")
	fruit.position = spawner_position
	fruit.is_endless_mode = true
	if spawner_type == position_type.right:
		fruit.is_vertical = false
	elif spawner_type == position_type.top:
		fruit.speed = fruit.speed * -1
	spawn_count += 1
	fruit_container.add_child(fruit)
	pass

func on_hit_fruit(fruit, area, is_alive, multiplier):
	var arrow = area.get_parent()
	if ("Arrow" in arrow.name && is_alive):
		spawn_hit += 1
		is_alive = false
		globals.add_medal((arrow.hit * multiplier))
		$GUI.update_endless_medal()
		$GUI.update_endless_fruitcount(max_spawn-spawn_hit)
		arrow.hit = arrow.hit + 1
		fruit.queue_free()
	pass 
