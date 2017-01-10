
extends Area2D

const SPEED = 200

var screen_size
var prev_shooting = false
var shootCount = 0

func _ready():
	screen_size = get_viewport().get_rect().size
	set_fixed_process(true)

func _fixed_process(delta):
	player_moving(delta)
	player_shooting()


func player_moving(delta):
	var motion = Vector2()
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		motion += Vector2(1, 0)
		
	var pos = get_pos()
	
	pos += motion*delta*SPEED
	if (pos.x < 0):
		pos.x = 0
	if (pos.x > screen_size.x):
		pos.x = screen_size.x
	if (pos.y < 0):
		pos.y = 0
	if (pos.y > screen_size.y):
		pos.y = screen_size.y
		
	set_pos(pos)

func player_shooting():
	var shooting = Input.is_action_pressed("shoot")
	#check if there is other shoot on map and prevent to fire twice
	prev_shooting = has_node("../shoot")
	
	if (shooting and not prev_shooting):
		shootCount += 1
		#print("Shoot count: " + str(shootCount) + " " + str(shootCount % 15 == 0))
		# Just pressed		
		var shoot = preload("res://prefabs/shoot.tscn").instance()
		# Use the Position2D as reference
		shoot.set_pos(get_node("shootFrom").get_global_pos())
		# Put it to parent so it is not moved by us
		get_node("..").add_child(shoot)
		# Play sound
		#get_node("sfx").play("shoot")
		
		#spawn Enemy Special ship depends on number of player shoots
		if(shootCount != 15 and (shootCount == 22 or shootCount % 15 == 0)):
			var enemyS = preload("res://prefabs/enemyS.tscn").instance()
			enemyS.set_pos(get_node("../enemyCFrom").get_global_pos())
			get_node("..").add_child(enemyS)

func hit_something():
	get_node("/root/game_state").lives -= 1
		
	if (get_node("/root/game_state").lives < 1):
		get_node("AnimatedSprite/AnimationPlayer").play("gun_anim")
		#get_node("sfx").play("sound_explode")
		get_parent().level_failed()
		set_fixed_process(false)
		
	else:
		#add delay and restart position
		get_node("AnimatedSprite/AnimationPlayer").play("gun_anim")
		var pos = get_pos()
		pos.x = 400
		set_pos(pos)
		#get_node("sfx").play("sound_explode")

func _on_ship_body_enter( body ):
	hit_something()

func _on_ship_area_enter( area ):
	if(area.is_in_group("enemies") and area.is_enemy()):
		hit_something()
