extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if (globals.activated_endless):
		$VBoxContainer/Endless.visible = true
		$VBoxContainer/Endless/Area2D/CollisionShape2D.disabled = false
	else:
		$VBoxContainer/Endless.visible = false
		$VBoxContainer/Endless/Area2D/CollisionShape2D.disabled = true
	
	$Hammond.visible = false
#	get_tree().change_scene("res://ArrowMan.tscn")
	pass # Replace with function body.

func _on_Start_mouse_entered():
	$Hammond.visible = true
	$Hammond.position = Vector2(350, 350)
	pass # Replace with function body.

func _on_Start_mouse_exited():
	$Hammond.visible = false
	pass # Replace with function body.

func _on_Endless_mouse_entered():
	$Hammond.visible = true
	$Hammond.position = Vector2(350, 400)
	pass # Replace with function body.

func _on_Endless_mouse_exited():
	$Hammond.visible = false
	pass # Replace with function body.

func _on_Quit_mouse_entered():
	$Hammond.visible = true
	if (globals.activated_endless):
		$Hammond.position = Vector2(350, 450)
	else:
		$Hammond.position = Vector2(350, 400)
	pass # Replace with function body.

func _on_Quit_mouse_exited():
	$Hammond.visible = false
	pass # Replace with function body.

func _on_Start_Area2D_area_entered(area):
	get_tree().change_scene("res://ArrowMan.tscn")
	pass # Replace with function body.

func _on_Quit_Area2D_area_entered(area):
	get_tree().quit()
	pass # Replace with function body.



