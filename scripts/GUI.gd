extends Control

func draw_arrows(isGoldeArrowActive):	
	for arrow in $CanvasLayer/ArrowContainer.get_children():
		arrow.queue_free()
	
	var i = 0
	while globals.get_arrows() > i:
		var arrowDup = null
		if isGoldeArrowActive && i % 5 == 0:
			arrowDup = $CanvasLayer/GoldenArrowBase.duplicate(8)
		else:
			arrowDup = $CanvasLayer/ArrowBase.duplicate(8)
		arrowDup.visible = true
		arrowDup.position = Vector2(990 - (i * 12), 40)
		$CanvasLayer/ArrowContainer.add_child(arrowDup)
		i += 1
	pass

func remove_arrow():
	var currentArrow = globals.get_arrows() - 1
	$CanvasLayer/ArrowContainer.get_child(currentArrow).queue_free()
	globals.set_arrows(currentArrow)
	
	if (currentArrow == 0):
		# Game over 
#		draw_arrows()
		pass
	pass

func update_score():
	$CanvasLayer/Score.text = "Score: " + str(globals.get_score())
	pass

func update_stage():
	$CanvasLayer/Stage.text = "Stage " + str(globals.get_level())
	pass