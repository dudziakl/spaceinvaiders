
extends Area2D

export var points = 0

var destroyed = false
var horizontalSpeed = 1
var verticalSpeed = 0.5 #0.03
var direction = -1
var acceleration = 1
var moveDown = false
var moveDownMaxPosition = 0
var maxMoveDown = 10

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	acceleration += delta * 0.1
	var newDirection = get_node("/root/level/boundaries").horizontal_direction_get()
	if(newDirection != direction):
		moveDown = true
	direction = newDirection
	#translate(Vector2(direction*horizontalSpeed*acceleration,verticalSpeed*acceleration))
	if(!moveDown):
		translate(Vector2(direction*horizontalSpeed*acceleration,0))
	else:
		#check if still go down
		if(moveDownMaxPosition == 0):
			moveDownMaxPosition =  get_pos().y + maxMoveDown
		
		if(get_pos().y > moveDownMaxPosition):
			# switch to hotizontal move
			moveDown = false
			moveDownMaxPosition = 0
		else:
			#move down
			translate(Vector2(0,verticalSpeed*acceleration))
		

func is_enemy():
	return not destroyed

func destroy():
	if (destroyed):
		return
	destroyed = true
	#animate explode
	get_node("AnimatedSprite/AnimationPlayer").play("inv_anim")
	set_fixed_process(false)
	#play explosion sound
	#get_node("sfx").play("sound_explode")
	# add points to score
	get_node("/root/game_state").score += points
	# call next invader to shoot
	if (is_in_group("bombers")): 
		if(get_parent().get_child_count() > 1):
			#print("Next enemy: " +get_parent().get_children()[1].get_name())
			get_parent().get_children()[1].add_to_group("bombers") = true	
	##queue_free()
	#check enemies left and if none then complete the level
	get_node("/root/level").check_if_level_completed()
	