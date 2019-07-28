extends Position2D

# Spawner details
enum position_type {top, bottom, right}
var current_position_type = position_type.right

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
var bound = 120

signal create_fruit

func _ready():
	max_view_x = get_viewport().size.x
	max_view_y = get_viewport().size.y
	
	#	current_position_type = randi() % position_type.size()
	randomize()
	match current_position_type:
		0: # TOP
			position.x = randi() % (int(get_viewport().size.x)-(bound*2)) + bound
			position.y = randi() % bound
		1: # BOTTOM
			position.x = randi() % (int(get_viewport().size.x)-(bound*2)) + bound
			position.y = randi() % bound + int(get_viewport().size.y)
		2: # RIGHT
			position.x = randi() % bound + int(get_viewport().size.x)
			position.y = randi() % (int(get_viewport().size.y)-(bound*2)) + bound

func _process(delta):
	
	# spawner movements
	if !is_random_movement:
		if current_position_type == position_type.right:
			if position.y + bound + pixel_bounds + movement > max_view_y: 
				direction = -1
			elif position.y - bound - pixel_bounds - movement < 0:
				direction = 1
				
			position.y = position.y + (movement * direction)
		elif current_position_type == position_type.top || current_position_type == position_type.bottom:
			if position.x + bound + pixel_bounds + movement > max_view_x: 
				direction = -1
			elif position.x - bound - pixel_bounds - movement < 0:
				direction = 1
				
			position.x = position.x + (movement * direction)
	else:
		if current_position_type == position_type.right:
			position.y = randi() % int(get_viewport().size.y)
		else:
			position.x = randi() % int(get_viewport().size.x) + 200
		pass
	
	# spawning
	if current_spawn_time == spawn_time_range.max:
		var s_count = get_node("/root/EndlessStage").spawn_count
		var m_count = get_node("/root/EndlessStage").max_spawn
		if s_count != m_count:
			emit_signal("create_fruit", current_position_type, position)
			current_spawn_time = randi()%spawn_time_range.min + spawn_time_range.offset
	else:
		current_spawn_time += 1

