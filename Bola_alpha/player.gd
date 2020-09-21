extends KinematicBody2D

# signal hit TODO Ver que hacer cuando choca pisot

""" This are public attributes, they can be
	modified from de main scene """
	
"""
const SPEED = 200
const GRAVITY = 100
const JUMP_HEIGHT = -1000
const UP = Vector2(0, -1)
"""

export (int) var SPEED
export (int) var GRAVITY
export (int) var JUMP_HEIGHT

const UP = Vector2(0, -1)

signal new_max

var max_height

var motion = Vector2()
""" On ready, we get the size of the screen """
func _ready():
	#screensize = get_viewport_rect().size
	print ("starting")
	max_height = position.y


func _physics_process(delta):
	
	#TODO here when death_of_player signal emited exit funciton and run player_game_over()
	
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		
	
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		
	else:
		motion.x = 0
		
	if is_on_floor():
		if max_height > position.y:
			max_height = position.y
			print(max_height)
			emit_signal("new_max")
			
		if Input.is_action_just_pressed("ui_up"):
			#$AnimatedSprite.play("jump")
			#yield(get_node("AnimatedSprite"), "animation_finished")
			
			motion.y += JUMP_HEIGHT
			
		else:
			$AnimatedSprite.play("idle")
			
	"""else: 
		$AnimatedSprite.play("air")"""

	motion = move_and_slide(motion, UP)
	
	
func player_game_over(death_position):
	print("BAK")
	position.y = death_position