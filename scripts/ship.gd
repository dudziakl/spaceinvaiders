
extends Area2D

const SPEED = 200

var screen_size
var prev_shooting = false
var lives = 3

func _ready():
	# Called every time the node is added to the scene.
	screen_size = get_viewport().get_rect().size
	set_fixed_process(true)

func _fixed_process(delta):
	player_moving(delta)	
	player_shooting()
	
	#update UI
	get_node("../UI/LivesValue").set_text(str(lives))
	#get_node("../UI/LivesScore").set_text(str(get_node("/root/game_state").score))


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

func _hit_something():
	if (lives > 0):
		#get_node("anim").play("explode")
		#get_node("sfx").play("sound_explode")
		#add delay and restart position
		lives += -1
		return
	#get_node("anim").play("explode")
	#get_node("sfx").play("sound_explode")
	#get_node("../hud/game_over").show()
	get_node("/root/scripts/game_state").game_over()
	get_parent().stop()
	set_process(false)

func _on_ship_body_enter( body ):
	_hit_something()

func _on_ship_area_enter( area ):
	if(area.is_in_group("enemies") and area.is_enemy()):
		_hit_something()
