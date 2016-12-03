
extends Area2D

const SPEED = 200

var screen_size
var prev_shooting = false
var killed = false

func _ready():
	# Called every time the node is added to the scene.
	screen_size = get_viewport().get_rect().size
	set_fixed_process(true)

func _fixed_process(delta):
	#moving
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
	
	#shooting
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
