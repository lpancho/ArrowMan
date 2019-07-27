extends Node2D

var speed = 400
var hit = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	move_local_x(speed * delta)
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # Replace with function body.