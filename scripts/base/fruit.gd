extends Node2D

var is_vertical = true
var has_bounds = false
var is_endless_mode = false
var extended_bounds = null
var speed = -100
var height = 50
var hits = 1
var is_alive = true

func _ready():
	height = $Sprite.texture.get_size().y / 2
	pass # Replace with function body.

func _process(delta):
	if is_vertical:
		move_local_y(speed * delta)
	else:
		move_local_x(speed * delta)
	
	if (extended_bounds != null):
		# extended bounds are for vertical enemies (y). meaning they are going up/down!
		# if the enemies reaches the extended bound for x. it will return to extended bound y position
		# then go up again like a cycle
		if (self.position.y + height < extended_bounds.x):
			self.position = Vector2(self.position.x, extended_bounds.y)
		elif (self.position.y - height > extended_bounds.y):
			self.position = Vector2(self.position.x, extended_bounds.x)
	elif (has_bounds):
		if (self.position.y - constants.BORDER_HEIGHT < 1 || self.position.y + height > get_viewport_rect().size.y):
			speed *= -1
	elif (self.position.y + height < 0):
#		if is_endless_mode:
#			queue_free()
#		else:
		self.position = Vector2(self.position.x, get_viewport_rect().size.y)
	elif (self.position.y - height > get_viewport_rect().size.y):
#		if is_endless_mode:
#			queue_free()
#		else:
		self.position = Vector2(self.position.x, 0)
	pass

func _on_Area2D_area_entered(area):
	
	var arrow = area.get_parent()
	if ("Arrow" in arrow.name && is_alive):
		is_alive = false
		globals.add_score((arrow.hit * get_score_multiplier()))
		get_node("../../GUI").update_score()
		arrow.hit = arrow.hit + 1
		queue_free()
	pass # Replace with function body.

func get_modified_size():
	return $Sprite.texture.get_size().y
	pass

func get_score_multiplier():
	for fruit in constants.fruits_dict["Fruits"]:
		if self.is_in_group(fruit["Name"]):
			return fruit["Multiplier"]
	return 0