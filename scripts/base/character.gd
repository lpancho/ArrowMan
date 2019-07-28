extends Node2D

# Make this as enum
export var state = ""
var current_scene = ""

var speed = 80
var isGoldenArrowActivated = false
var arrowFiredCounter = 0

var current_charge = 1
const MAX_CHARGE = 5
const BORDER_HEIGHT = 115
const PLAYER_HEIGHT = 40

const MAX_PULL_FRAME = 4

onready var bow = $Bow
var arrowObj = null
var goldenArrowObj = null

func _ready():
	arrowObj = load("res://scenes/misc/Arrow.tscn")
	goldenArrowObj = load("res://scenes/misc/GoldenArrow.tscn")
	$Body.scale = Vector2(.5, .5)
	$Body.position.y = 5
	
	$Legs.scale = Vector2(.5, .5)
	$Legs.position.y = 45
	pass # Replace with function body.

func _input(event):
	
	# We must not allow InputEventMouseMotion
	if (!event.is_class("InputEventMouseMotion")):
		if (event.is_action_pressed("ui_select") 
				&& globals.get_arrows() != 0):
			
			$Bow/AnimatedSprite.animation = "pull"
			$Bow/AnimatedSprite.play()
			pass
		elif (event.is_action_released("ui_select") 
				&& $Bow/AnimatedSprite.animation == "pull" 
				&& $Bow/AnimatedSprite.frame == MAX_PULL_FRAME
				&& globals.get_arrows() != 0):
			
			var isDivisibleBy5 = (arrowFiredCounter + 1) % 5 == 0
			if (isGoldenArrowActivated && isDivisibleBy5):
				randomize()
				var arrow = goldenArrowObj.instance()
				arrow.position = self.bow.global_position
				self.get_parent().add_child(arrow)
				
				for i in range(8):
					arrow = goldenArrowObj.instance()
					arrow.position = Vector2(self.bow.global_position.x, rand_range(100, 550))
					self.get_parent().add_child(arrow)
			else:
				var arrow = arrowObj.instance()
				arrow.add_to_group("Arrows")
				arrow.position = self.bow.global_position
				self.get_parent().add_child(arrow)
				
				arrow = arrowObj.instance()
				arrow.position = self.bow.global_position
				self.get_parent().add_child(arrow)
			
			arrowFiredCounter += 1
			if (state != "MENU"):
				get_tree().get_root().get_node(current_scene + "/GUI").remove_arrow()
			
			$Bow/AnimatedSprite.animation = "steady"
		elif !event.is_pressed():
			$Bow/AnimatedSprite.animation = "steady"
	else:
		if (state != "MENU"):
			var mouse_y = get_global_mouse_position().y;
			if (mouse_y > BORDER_HEIGHT && mouse_y < get_viewport_rect().size.y - PLAYER_HEIGHT):
				self.position.y = mouse_y
			pass
	pass
	
func enable_process(value):
	set_process(value)
	pass