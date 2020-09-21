extends Node

export (float) var platformHeight
export (int) var MaxSize 

signal death_of_player(position)


# class member variables go here, for example:
var platform_Num = []
var platform_id = 0
var next_rows_height = 630
var dead_line = 500
var build_wall_here = 630
var deathray = 630
var score = 0
var death_position



func _ready():
	new_game()
	$HUD.show_all()
		
	
	
func new_game():	
	# Called when the node is added to the scene for the first time.

	generate_bricks_row(floor_array()) #first platform/the floo
	next_rows_height = build_wall_here -60*3
	
	for i in range(3):
		draw_next_row()

func _process(delta):
	
	if game_over():
		print("GAME OVER")
		death_position = $Player.position.y
		#$Player.hide()
		emit_signal("death_of_player", death_position)
	else:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up"):
			$HUD.hide_all()
		
		bulldozing_platforms()
		#creating_platforms()	
		var platform = platform_Num.back()
		if platform.position.y > $Player.position.y - dead_line:
				draw_next_row()
	
			

func draw_next_row():
	if next_rows_height < build_wall_here:
		generate_bricks_row(wall_array())
	else:
		random_row_creator()
		
func random_row_creator():
	randomize()
	var a = randi() % 2 + 2+1
	generate_bricks_row(random_array())
	next_rows_height = next_rows_height -60*(a)





func add_brick_instance(name, position, parent):
	var wall = load("res://wall.tscn").instance()
	wall.set_name(name)
	wall.position.x = position
	parent.add_child(wall)
#	print(wall.position)

# func creatin_platforms:
	
func bulldozing_platforms():
	var platform = platform_Num[0]
	if platform.position.y > $Player.position.y + dead_line:
		deathray = platform.position.y
		platform_Num.pop_front()
		remove_child(platform)
		platform.queue_free()
		
func game_over():
	if $Player.position.y > deathray:
		return true

	else: return false

	
func floor_array():
	var row = []
	for i in range(MaxSize+1):
		row.push_back(true)
	return row

func generate_bricks_row(row):
	var platform = Node2D.new()
	platform.set_name("Platform" + str(platform_id))
	platform_id = platform_id +1
	platform.position.y = build_wall_here;
	platform.position.x = 30
	for i in range(row.size()):
		if row[i]: 
			add_brick_instance("wall" + str(i), i*60, platform)
	add_child(platform)
	platform_Num.append(platform)
	build_wall_here = build_wall_here - 60
	
	
func random_array():
	var array = []
	array.push_back(1)
	for i in range(MaxSize-1):
		randomize()
		array.push_back(randi() % 2)
	array.push_back(1)
	#print(array)
	return array
	
func wall_array():
	var array = []
	array.push_back(1)
	for i in range(MaxSize-1):
		array.push_back(0)
	array.push_back(1)
	#print(array)
	return array