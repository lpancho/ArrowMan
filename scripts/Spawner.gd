extends Position2D

# Spawner details
enum positions {top, bottom, right}
export var current_position = positions.right

# random range
# rand value = 0 to min + offset
# max value = max(0 to min + offset)
var spawn_time_range = {
	offset = 150,
	min = 151,
	max = 300
}
var current_spawn_time = spawn_time_range.max
var spawn_count = 0
var is_random_movement = false

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
	
	# spawner movements
	if !is_random_movement:
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
	else:
		if current_position == positions.right:
			position.y = randi() % int(get_viewport().size.y)
		else:
			position.x = randi() % int(get_viewport().size.x) + 200
		pass
	
	# spawning
	if current_spawn_time == spawn_time_range.max:
		create_random_fruit()
		current_spawn_time = randi()%spawn_time_range.min + spawn_time_range.offset
	else:
		current_spawn_time += 1

func create_random_fruit():
	randomize()
	var fruit = load(fruits_scn[randi() % fruits_scn.size()]).instance()
	fruit.position = position
	fruit.is_endless_mode = true
	if current_position == positions.right:
		fruit.is_vertical = false
	elif current_position == positions.top:
		fruit.speed = fruit.speed * -1
		
	get_node("/root/EndlessStage").add_child(fruit)
	pass


