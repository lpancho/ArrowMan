extends Control

onready var stage_mode = 	$VBoxContainer/StageMode
onready var endless_mode = 	$VBoxContainer/EndlessMode
onready var unlockables = 	$VBoxContainer/Unlockables
onready var quit = 			$VBoxContainer/Quit
onready var hammond = 		$Hammond

var stage_mode_scn = 		"res://scenes/stages/Stage.tscn"
var endless_mode_scn = 		"res://scenes/stages/EndlessStage.tscn"

enum SELECTIONS { STAGE_MODE, ENDLESS_MODE, UNLOCKABLES, QUIT }

func _ready():
	
	# mouse_entered - show character hammond
	stage_mode.connect("mouse_entered", self, "_on_Label_mouse_entered", [Vector2(100, 350)])
	endless_mode.connect("mouse_entered", self, "_on_Label_mouse_entered", [Vector2(100, 415)])
	unlockables.connect("mouse_entered", self, "_on_Label_mouse_entered", [Vector2(100, 475)])
	quit.connect("mouse_entered", self, "_on_Label_mouse_entered", [Vector2(100, 530)])
	
	# area_enterd - for the selection of the player
	stage_mode.get_node("Area2D").connect("area_entered", self, "_on_Area2D_area_entered", [SELECTIONS.STAGE_MODE])
	endless_mode.get_node("Area2D").connect("area_entered", self, "_on_Area2D_area_entered", [SELECTIONS.ENDLESS_MODE])
	unlockables.get_node("Area2D").connect("area_entered", self, "_on_Area2D_area_entered", [SELECTIONS.UNLOCKABLES])
	quit.get_node("Area2D").connect("area_entered", self, "_on_Area2D_area_entered", [SELECTIONS.QUIT])
	
	if (globals.activated_endless):
		endless_mode.get_node("Unlock").visible = false
		unlockables.get_node("Unlock").visible = false
		
		# change alpha value to 1 - remove transparency
		endless_mode.set("custom_colors/font_color", Color(0, 0, 0, 1))
		unlockables.set("custom_colors/font_color", Color(0, 0, 0, 1))
	
	hammond.visible = false
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		print(event.position)
	pass

func _on_Label_mouse_entered(position):
	hammond.visible = true
	hammond.position = position
	pass # Replace with function body.

func _on_Label_mouse_exited():
	hammond.visible = false
	pass # Replace with function body.

func _on_Area2D_area_entered(area, selection):
	match selection:
		SELECTIONS.STAGE_MODE:
			globals.set_arrows(constants.MAX_ARROWS)
			globals.set_level(1)
			globals.set_score(0)
			get_tree().change_scene(stage_mode_scn)
		SELECTIONS.ENDLESS_MODE:
			if globals.activated_endless:
				get_tree().change_scene(endless_mode_scn)
		SELECTIONS.UNLOCKABLES:
			if globals.activated_endless:
				get_tree().change_scene(endless_mode_scn)
			pass
		SELECTIONS.QUIT:
			get_tree().quit()
	pass # Replace with function body.












