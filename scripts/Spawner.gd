extends Position2D

# Spawner positions
enum positions {top, bottom, right}
export var current_position = positions.right

# Movement of spawner
var direction = 1
var movement = 1
var pixel_bounds = 30

# Screen view
var max_view_x = 0
var max_view_y = 0

# List of fruits
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

func _ready():
	max_view_x = get_viewport().size.x
	max_view_y = get_viewport().size.y
	
func _process(delta):
	if current_position == positions.right:
		if position.y + pixel_bounds + movement > max_view_y: 
			direction = -1
		elif position.y - pixel_bounds - movement < 0:
			direction = 1
			
		position.y = position.y + (movement * direction)
	elif current_position == positions.top || current_position == positions.bottom:
		if position.x + pixel_bounds + movement > max_view_x: 
			direction = -1
		elif position.x - pixel_bounds - movement < 0:
			direction = 1
			
		position.x = position.x + (movement * direction)

func create_random_fruit():
	randomize()
	var fruit = load(fruits_scn[randi() % fruits_scn.size()]).instance()
	fruit.position = position
	if current_position == positions.right:
		fruit.is_vertical = false
	elif current_position == positions.top:
		fruit.speed = fruit.speed * -1
		
	get_node("/root/EndlessStage").add_child(fruit)
	pass

func _on_TimerSpawn_timeout():
	create_random_fruit()
	pass # Replace with function body.

func _on_TimerMove_timeout():
	randomize()
	if current_position == positions.right:
		position.y = randi() % int(get_viewport().size.y)
	else:
		position.x = randi() % int(get_viewport().size.x) + 200
	pass # Replace with function body.


