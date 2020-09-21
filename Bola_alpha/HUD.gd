extends CanvasLayer

signal start_game



"""func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
"""

func show_all():
	$IntroLabel.show()
	$StartButton.show()

func hide_all():
	$IntroLabel.hide()
	$StartButton.hide()	
	
	
func _on_StartButton_pressed():
	$IntroLabel.hide()
	$StartButton.hide()
	emit_signal("start_game")
	
	
	
"""
func show_game_over():
show_message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Dodge the\nCreeps!"
	$MessageLabel.show()
"""

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
