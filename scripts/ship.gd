
extends Area2D

const SPEED = 200

var screen_size
var prev_shooting = false
var lives = 3

func _ready():
	get_node("../UI/GameOverLabel").hide()
	screen_size = get_viewport().get_rect().size
	set_fixed_process(true)

func _fixed_process(delta):
	player_moving(delta)
	player_shooting()
	
	#update UI
	get_node("../UI/LivesValue").set_text(str(lives))
	get_node("../UI/ScoreValue").set_text(str(get_node("/root/game_state").score))


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
		# Just pressed
		var shoot = preload("res://prefabs/shoot.tscn").instance()
		# Use the Position2D as reference
		shoot.set_pos(get_node("shootFrom").get_global_pos())
		# Put it to parent so it is not moved by us
		get_node("..").add_child(shoot)
		# Play sound
		#get_node("sfx").play("shoot")

func hit_something():
	lives -= 1
	get_node("../UI/LivesValue").set_text(str(lives))
	
	if (lives < 1):
		#get_node("anim").play("explode")
		#get_node("sfx").play("sound_explode")
		print("game over")
		get_node("../UI/GameOverLabel").show()
		get_node("/root/game_state").game_over()
		set_fixed_process(false)
		set_process(false)
	else:
		#add delay and restart position
		var pos = get_pos()
		pos.x = 400
		set_pos(pos)
		#get_node("anim").play("explode")
		#get_node("sfx").play("sound_explode")

func _on_ship_body_enter( body ):
	hit_something()

func _on_ship_area_enter( area ):
	if(area.is_in_group("enemies") and area.is_enemy()):
		hit_something()
